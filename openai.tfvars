/*
This file contains all the values for the variables defined in variables.tf
*/

# Variable values for Azure resource group
rg_name     = "rg-dev-test" # This can also be stored in GitHub secrets
rg_location = "Canada East" # This can also be stored in GitHub secrets
environment = "dev"         # This can also be stored in GitHub secrets

# Variable value for the OpenAI and model deployment
oai_account_name          = "openai-dev" # This can also be stored in GitHub secrets
oai_application_name      = "openai-dev"
oai_custom_subdomain_name = "openai-dev-12345"
oai_default_tags_enabled  = true
oai_model_deployment = {
  "gpt-4-32k" = {
    name          = "gpt-4-32k"
    model_format  = "OpenAI"
    model_name    = "gpt-4-32k"
    model_version = "0613"
    scale_type    = "Standard"
  },
  "text-embedding-ada-002" = {
    name          = "text-embedding-ada-002"
    model_format  = "OpenAI"
    model_name    = "text-embedding-ada-002"
    model_version = "2"
    scale_type    = "Standard"
  }
}
oai_dynamic_throttling_enabled = false
oai_environment                = "Dev"
oai_identity = {
  type = "SystemAssigned"
}
oai_local_auth_enabled                 = true
oai_outbound_network_access_restricted = false
oai_public_network_access_enabled      = true
oai_sku_name                           = "S0"
oai_tags = {
  Owner       = "Terence Luk"
  Cost_Center = "IT"
}

# OpenAI Log Analytics
oai_log_analytics_workspace_name      = "log-openai"
oai_log_analytics_workspace_sku       = "PerGB2018"
oai_log_analytics_workspace_retention = 30

# Container App Log Analytics
ca_log_analytics_workspace_name      = "log-containerapp"
ca_log_analytics_workspace_sku       = "PerGB2018"
ca_log_analytics_workspace_retention = 30

# Container App
container_app_env_name     = "cae-chatbot-ui"
container_app_env_location = "Canada East"
container_app_name         = "ca-chatbot-ui"
ca_revision_mode           = "Single"

# Container App Container Configuration
container_name   = "chatbot-ui"
container_image  = "ghcr.io/mckaywrigley/chatbot-ui:main"
container_cpu    = 0.25
container_memory = "0.5Gi"

# Container App Container Environmental Variables
OPENAI_API_TYPE     = "azure"
OPENAI_API_VERSION  = "2023-03-15-preview"
AZURE_DEPLOYMENT_ID = "gpt-4-32k"
DEFAULT_MODEL       = "gpt-4-32k"

# Container App Ingress Configuration Variables
ingress_external_enabled               = true
ingress_target_port                    = 3000
ingress_traffic_weight_percentage      = 100
ingress_traffic_weight_latest_revision = true


# Azure Monitor Diagnostic Setting
oai_diagnostic_name           = "OpenAI Logging"
oai_diagnostic_category_group = "allLogs"
oai_diagnostic_metric         = "AllMetrics"

# Entra ID App Registration / Service Principal
oai_entra_id_app_reg_name = "ca-chatbot-ui"