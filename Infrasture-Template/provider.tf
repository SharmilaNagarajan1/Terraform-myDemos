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
     client_id           = "5d1d84c4-7500-45a5-9748-8f553761f26b"
     client_secret       = var.client_secret
     subscription_id     ="ac74bec0-8fd8-4cdc-8472-6e56c70908f7"
     tenant_id           ="32faf645-4551-4bc0-95bc-c287389f13dd"

    }
  
