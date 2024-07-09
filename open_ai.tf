# Use the Terraform Registry OpenAI module for deployment: https://registry.terraform.io/modules/Azure/openai/azurerm/latest
module "openai" {
  source                             = "Azure/openai/azurerm"
  version                            = "0.1.3"
  location                           = azurerm_resource_group.oai_rg.location
  resource_group_name                = azurerm_resource_group.oai_rg.name
  account_name                       = var.oai_account_name
  application_name                   = var.oai_application_name
  custom_subdomain_name              = var.oai_custom_subdomain_name
  default_tags_enabled               = var.oai_default_tags_enabled
  deployment                         = var.oai_model_deployment
  dynamic_throttling_enabled         = var.oai_dynamic_throttling_enabled
  environment                        = var.oai_environment
  identity                           = var.oai_identity
  local_auth_enabled                 = var.oai_local_auth_enabled
  outbound_network_access_restricted = var.oai_outbound_network_access_restricted
  public_network_access_enabled      = var.oai_public_network_access_enabled
  sku_name                           = var.oai_sku_name
  tags                               = var.oai_tags
  depends_on = [
    azurerm_resource_group.oai_rg,
    azurerm_log_analytics_workspace.oai_log_analytics_workspace,
  ]
}