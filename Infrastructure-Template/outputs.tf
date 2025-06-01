output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "azurerm_virtual_network" {
   value = azurerm_virtual_network.vnet.name
}

  output "subnet-ag" {
    value = azurerm_subnet.ag-subnet.name
  }

  output "subnet-vm" {
    value = azurerm_subnet.vm-subnet.name
  }

output "vm-name1" {
  value = azurerm_virtual_machine.vm[0].name
  }

  output "vm-name2" {
  value = azurerm_virtual_machine.vm[1].name
  }


  output "app-gw" {
    value = azurerm_application_gateway.app-gw.name
  }

  output "lb" {
    value = azurerm_lb.Internal-lb.name
  }

  output "app-service-login"{
    value = azurerm_linux_web_app.webapp1.name
  }

    output "app-service-checkout"{
    value = azurerm_linux_web_app.webapp2.name
  }

  output "azurerm_network_interface1" {
    value = azurerm_network_interface.nic[0].name
  }

   output "azurerm_network_interface2" {
    value = azurerm_network_interface.nic[1].name
  }
