resource "azurerm_resource_group" "oai_rg" {
  location = var.rg_location
  name     = var.rg_name
}