resource "azurerm_application_gateway" "app-gw" {
  name                = var.application-gw
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.ag-subnet.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  backend_address_pool {
    name = "login-backend"
    fqdns = ["login-app-service.azurewebsites.net"]
  }

    backend_address_pool {
    name = "checkout-backend"
    fqdns = ["checkout-app-service.azurewebsites.net"]
  }

    backend_address_pool {
    name            = "ilb-backend-pool"
    ip_addresses    = ["10.0.2.100"]#Internal Load Balancer's private IP
    
  
  }

  probe {
    name = "login-probe"
    protocol = "Http"
    path = "/"
    interval = 30
    timeout = 30
    unhealthy_threshold = 3
    pick_host_name_from_backend_http_settings = true
  }

  probe {
    name = "checkout-probe"
    protocol = "Http"
    path = "/"
    interval = 30
    timeout = 30
    unhealthy_threshold = 3
    pick_host_name_from_backend_http_settings = true
  }

  probe {
    name = "payment-probe"
    protocol = "Http"
    path = "/"
    interval = 30
    timeout = 30
    unhealthy_threshold = 3
    host    = "10.0.2.100"
  }

  backend_http_settings {
    name                                = "login-http-setting"
    port                                = 80
    protocol                            = "Http"
    cookie_based_affinity               = "Disabled"
    request_timeout                     = 20
    pick_host_name_from_backend_address = true
    probe_name                          = "login-probe"
  }

  backend_http_settings {
    name                                = "checkout-http-setting"
    port                                = 80
    protocol                            = "Http"
    cookie_based_affinity               = "Disabled"
    request_timeout                     = 20
    pick_host_name_from_backend_address = true
    probe_name                          = "checkout-probe"
  }

  backend_http_settings {
    name                  = "payment-http-setting"
    port                  = 80
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 20
    probe_name            = "payment-probe"
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  url_path_map {
    name                               = "proj-url-path-map"
    default_backend_address_pool_name  = "login-backend"
    default_backend_http_settings_name = "login-http-setting"

    path_rule {
      name                        = "login-path"
      paths                       = ["/login/"]
      backend_address_pool_name   = "login-backend"
      backend_http_settings_name  = "login-http-setting"
    }

    path_rule {
      name                        = "checkout-path"
      paths                       = ["/checkout/"]
      backend_address_pool_name   = "checkout-backend"
      backend_http_settings_name  = "checkout-http-setting"
    }

    path_rule {
      name                        = "payment-path"
      paths                       = ["/payment/"]
      backend_address_pool_name   = "ilb-backend-pool"
      backend_http_settings_name  = "payment-http-setting"
    }
  }

  request_routing_rule {
    name                       = "url-path-routing-rule"
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "http-listener"
    url_path_map_name          = "proj-url-path-map"
    priority                   = 100
  }
