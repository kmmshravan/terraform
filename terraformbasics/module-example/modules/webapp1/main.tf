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

resource "azurerm_resource_group" "weapp12" {
  name = "weapp12"
  location = "canadacentral"
}

resource "azurerm_virtual_network" "weapp12" {
  resource_group_name = azurerm_resource_group.weapp12.name
  location = azurerm_resource_group.weapp12.location
  name              = "weappvnet"
  address_space = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "weapp12" {
  resource_group_name = azurerm_resource_group.weapp12.name
  name = "weappsubnet"
  address_prefixes = ["10.0.0.0/26"]
  virtual_network_name = azurerm_virtual_network.weapp12.name
  delegation {
    name = "example-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_service_plan" "weapp12" {
  name                = "weapp12"
  resource_group_name = azurerm_resource_group.weapp12.name
  location            = azurerm_resource_group.weapp12.location
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "weapp12" {
  name                = "weapp12"
  resource_group_name = azurerm_resource_group.weapp12.name
  location            = azurerm_service_plan.weapp12.location
  service_plan_id     = azurerm_service_plan.weapp12.id

  site_config {
    always_on = false
  }

  virtual_network_subnet_id = azurerm_subnet.weapp12.id
}
