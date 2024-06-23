terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.97.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "f0cd8e29-6633-4eaa-90af-9d795a4fb832" # Ihre Subscription ID
  tenant_id       = "8914cc15-c6a7-405a-9adb-072807fd5e4d" # Ihr Tenant ID
}

