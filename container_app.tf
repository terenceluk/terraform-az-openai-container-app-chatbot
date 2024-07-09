# Create and configure a Container App Environment
resource "azurerm_container_app_environment" "ca_environment" {
  name                       = var.container_app_env_name
  location                   = azurerm_resource_group.oai_rg.location
  resource_group_name        = azurerm_resource_group.oai_rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.ca_log_analytics_workspace.id
}

# Create and configure a Container App
resource "azurerm_container_app" "ca" {
  name                         = var.container_app_name
  container_app_environment_id = azurerm_container_app_environment.ca_environment.id
  resource_group_name          = azurerm_resource_group.oai_rg.name
  revision_mode                = var.ca_revision_mode

  # Configure the secrets that will be stored in the container app
  secret {
    name  = "openai-api-primary-key"
    value = module.openai.openai_primary_key
  }

  secret {
    name  = "openai-api-secondary-key"
    value = module.openai.openai_secondary_key
  }

  secret {
    name  = "openai-endpoint"
    value = module.openai.openai_endpoint
  }

  secret {
    name  = "microsoft-provider-authentication-secret"
    value = azuread_application_password.oai_app_pass.value
  }

  ingress {
    external_enabled = var.ingress_external_enabled
    target_port      = var.ingress_target_port
    traffic_weight {
      percentage      = var.ingress_traffic_weight_percentage
      latest_revision = var.ingress_traffic_weight_latest_revision
    }
  }

  template {
    container {
      name   = var.container_name
      image  = var.container_image
      cpu    = var.container_cpu
      memory = var.container_memory
      env {
        name        = "OPENAI_API_KEY"
        secret_name = "openai-api-primary-key" # Use the secret storing the OpenAI primary key created in the Container App
      }
      env {
        name        = "OPENAI_API_HOST"
        secret_name = "openai-endpoint" # Use the secret storing the OpenAI endpoint created in the Container App
      }
      env {
        name  = "OPENAI_API_TYPE"
        value = var.OPENAI_API_TYPE
      }
      env {
        name  = "OPENAI_API_VERSION"
        value = var.OPENAI_API_VERSION
      }
      env {
        name  = "AZURE_DEPLOYMENT_ID"
        value = var.AZURE_DEPLOYMENT_ID
      }
      env {
        name  = "DEFAULT_MODEL"
        value = var.DEFAULT_MODEL
      }
    }
  }
  depends_on = [
    module.openai,
    azurerm_container_app_environment.ca_environment,
    azuread_application_password.oai_app_pass
  ]
}