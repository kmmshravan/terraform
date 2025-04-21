terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.26.0"
    }

  }
  required_version = ">= 1.9.0"
}
provider "azurerm" {
    features {
      
    }
  
}

variable "resource_group_name" {
  description = "resource group to be created"
  type = string
  default = "testrg"
  
}
variable "storage_account" {
  description = "storage account to be created"
  type = string
  default = "srastgrg1"
  
}
variable "tags_list" {
  type = map(string)
  default = {
    "environment" = "dev"
    "owner" = "itsme"
    "purpose" = "learning"
  }
  
}

resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group_name
  location = "West Europe"
}

resource "azurerm_storage_account" "rg1" {
  name                     = var.storage_account
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags_list
}

output "resource_id" {
  value = azurerm_storage_account.rg1.id
  
}