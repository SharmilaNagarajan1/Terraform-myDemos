resource "azurerm_lb" "Internal-lb" {
  name                = var.load-balancer
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                           = "int-fronend"
    subnet_id                      = azurerm_subnet.vm-subnet.id
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.100"

  }
}

resource "azurerm_lb_backend_address_pool" "lb" {
  loadbalancer_id = azurerm_lb.Internal-lb.id
  name            = "BackEndAddressPool"
}
