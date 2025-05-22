terraform {
    required_providers {
      azurerm ={
        source = "hashicorp/azurerm"
        version = "~> 4.29.0"
      }
    }
   required_version = ">= 1.9.0"

}

provider "azurerm" {
    features {}
  
}

#create two resource gropus using count
resource "azurerm_resource_group" "rg" {
  count = 2
  name = "meta-rg-${count.index}"
  location = "Australia East"
  # lifecycle {
  #   create_before_destroy = true
  # }
}

#create a VNet

resource "azurerm_virtual_network" "vnet" {
  name = "my-VNet"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rg[0].location
  resource_group_name = azurerm_resource_group.rg[0].name
    
  }

  #create a subnet that depends on VNet
  resource "azurerm_subnet" "subnet" {
    name = "my-subnet"
    resource_group_name = azurerm_resource_group.rg[0].name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.1.0/24"]

    depends_on = [azurerm_virtual_network.vnet]
  }

  #Create a map of storage accounts for_each 
  locals {
    storage_accounts = {
    "dev"   = "devstorageacc1988"
    "stage" = "stagestorageacc1988"
    "uat"  = "uatstorageacc1988"
  }
}

resource "azurerm_storage_account" "storage" {
  for_each             = local.storage_accounts
  name                 = each.value
  resource_group_name  = azurerm_resource_group.rg[0].name
  location             = azurerm_resource_group.rg[0].location
  account_tier         = "Standard"
  account_replication_type = "GRS"
  lifecycle {
    ignore_changes = [account_replication_type]
  }
  
}