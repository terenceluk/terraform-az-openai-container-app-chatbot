terraform {
  backend "local" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"

    }
    modtm = {
      source  = "Azure/modtm"
      version = ">= 0.1.8, < 1.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "=1.14.0"
    }
  }
}

provider "modtm" {
  enabled = false
}

# Fill in the App Registration / Service Principal client ID and secret, tenant ID, and subscription ID.
provider "azurerm" {
  client_id       = "xxxxxxxx-xxx-xxx-xxx-xxxxxxxxxxx"
  client_secret   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  tenant_id       = "xxxxxxxx-xxx-xxx-xxx-xxxxxxxxxxx"
  subscription_id = "xxxxxxxx-xxx-xxx-xxx-xxxxxxxxxxx"
  features {
  }
}
