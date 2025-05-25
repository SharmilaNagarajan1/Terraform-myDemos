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
    name = "frontend-port"
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
    ip_addresses    = ["10.0.1.100"]#Internal Load Balancer's private IP
    
  
  }

  backend_http_settings {
    name                  = "http_setting"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  url_path_map {
     name                              = "proj-url-path-map"
     default_backend_address_pool_name = "login-backend"
     default_backend_http_settings_name = "http_setting"

     path_rule {
       name                         = "login-path"
       paths                        = ["/login/"]
       backend_address_pool_name    = "login-backend"
       backend_http_settings_name   = "http_setting"
     }       

     path_rule {
       name                        = "checkout-path"
       paths                       = ["/checkout/"]
       backend_address_pool_name   = "checkout-backend"
       backend_http_settings_name  = "http_setting"
     }    

     path_rule {
       name                       = "payment-path"
       paths                      = ["/payment/"]
       backend_address_pool_name  = "ilb-backend-pool"
       backend_http_settings_name = "http_setting"
     }                                

  }

  request_routing_rule {
    name                       = "routing_rule"
    priority                   = 100
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "http-listener"
    url_path_map_name          = "proj-url-path-map" 

}
}
