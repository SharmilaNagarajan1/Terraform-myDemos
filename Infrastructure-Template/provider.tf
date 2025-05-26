terraform {
    required_version = "1.12.1"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.29.0"

    }
  }
}

provider "azurerm" {
    features {}
    resource_provider_registrations = "none"
     
    }
  
