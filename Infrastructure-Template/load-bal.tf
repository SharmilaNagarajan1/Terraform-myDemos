resource "azurerm_lb" "Internal-lb" {
  name                = var.load-bal
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

 frontend_ip_configuration {
    name                           = "LoadBalancerFrontEnd"
    subnet_id                      = azurerm_subnet.vm-subnet.id
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.2.100"

  }
}

resource "azurerm_lb_backend_address_pool" "lb" {
  loadbalancer_id = azurerm_lb.Internal-lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "http" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.Internal-lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http" {
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"  
  probe_id                       = azurerm_lb_probe.http.id
  loadbalancer_id                = azurerm_lb.Internal-lb.id
}
