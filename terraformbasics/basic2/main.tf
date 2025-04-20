terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.26.0"
    }
  }
  required_version = ">= 1.11.4"
  backend "azurerm" {
    resource_group_name  = "tfstrg1"          # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name        = "tfstrgact1"                              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name              = "tfstate"                               # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                         = "dev.terraform.tfstate"                # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }

}
provider "azurerm" {
  features {
    
  }
 
}
resource "azurerm_resource_group" "tfrg1" {
  name = "tfstrg1"
  location = "eastus2"
  
}

resource "azurerm_storage_account" "tfstorage1" {
  name                     = "tfstrgact1"
  resource_group_name      = azurerm_resource_group.tfrg1.name
  location                 = azurerm_resource_group.tfrg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
    purpose = "tfstatefile"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstorage1.id
  container_access_type = "private"
}