# Create and configure a Log Analytics Workspace for Azure OpenAI
resource "azurerm_log_analytics_workspace" "oai_log_analytics_workspace" {
  name                = var.oai_log_analytics_workspace_name
  location            = azurerm_resource_group.oai_rg.location
  resource_group_name = azurerm_resource_group.oai_rg.name
  sku                 = var.oai_log_analytics_workspace_sku
  retention_in_days   = var.oai_log_analytics_workspace_retention # handles retention for all logs
  depends_on = [
    azurerm_resource_group.oai_rg,
  ]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
resource "azurerm_monitor_diagnostic_setting" "oai_diagnostics" {
  name                       = var.oai_diagnostic_name
  target_resource_id         = module.openai.openai_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.oai_log_analytics_workspace.id

  enabled_log {
    category_group = var.oai_diagnostic_category_group
    #enabled        = true

    # Deprecated in favor of `azurerm_storage_management_policy` but this only manages the lifecycle of blobs in a storage account and not Log Analytics
    #retention_policy {
    #  enabled = false
    #}
  }

  metric {
    category = var.oai_diagnostic_metric
    enabled  = true

    # Deprecated in favor of `azurerm_storage_management_policy` but this only manages the lifecycle of blobs in a storage account and not Log Analytics
    #  retention_policy {
    #    enabled = false
    #    #days    = 0
    # }
  }
}

# Create and configure a Log Analytics Workspace for the Container App Environment
resource "azurerm_log_analytics_workspace" "ca_log_analytics_workspace" {
  name                = var.ca_log_analytics_workspace_name
  location            = azurerm_resource_group.oai_rg.location
  resource_group_name = azurerm_resource_group.oai_rg.name
  sku                 = var.ca_log_analytics_workspace_sku
  retention_in_days   = var.ca_log_analytics_workspace_retention
  depends_on = [
    azurerm_resource_group.oai_rg,
  ]
}