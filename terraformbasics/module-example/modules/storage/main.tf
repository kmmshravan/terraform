terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.26.0"
    }
  }
  required_version = ">= 1.11.4"
}
provider "azurerm" {
    features {
      
    }
  
}

variable "azurerm_resource_group" {
    description = "resource group name"
    default = "testrg1"
    type = string
}

variable "azurerm_storage_account" {
    description = "storage account name"
    default = "modstorg1"
    type = string
  
}

variable "tags" {
    type = map(string)
    default = {
        "environment" = "dev"
        "owner" = "me"
        "purpose" = "learning"
    }
  
}

resource "azurerm_resource_group" "rg1" {
    name = var.azurerm_resource_group
    location = "eastus2"
  
}

resource "azurerm_storage_account" "rg1" {
  name                     = var.azurerm_storage_account
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}