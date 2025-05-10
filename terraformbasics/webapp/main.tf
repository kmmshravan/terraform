provider "azurerm" {
  
}
module "webapp1" {
  source = "../module-example/modules/webapp1"
}