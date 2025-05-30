resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
  }

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = [ "10.0.0.0/16" ]
}

resource "azurerm_subnet" "ag-subnet" {
  name = var.subnet-ag-name
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name 
  address_prefixes = [ "10.0.1.0/24" ]
}
resource "azurerm_subnet" "vm-subnet" {
  name = var.subnet-name
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [ "10.0.2.0/24" ]
}

resource "azurerm_public_ip" "pip" {
  name                = var.public-ip
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
