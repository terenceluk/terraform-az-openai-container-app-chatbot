# Output OpenAI Values

output "openai_endpoint" {
  description = "OpenAI Endpoint"
  value       = module.openai.openai_endpoint
}

output "openai_id" {
  description = "OpenAI ID"
  value       = module.openai.openai_id
}

output "openai_primary_key" {
  description = "OpenAI Primary Key"
  value       = module.openai.openai_primary_key
  sensitive   = true
}

output "openai_secondary_key" {
  description = "OpenAI Secondary Key"
  value       = module.openai.openai_secondary_key
  sensitive   = true
}

output "openai_subdomain" {
  description = "OpenAI Subdomain"
  value       = module.openai.openai_subdomain
}

# Output Container App Values

output "azurerm_container_app_url" {
  value = azurerm_container_app.ca.ingress[0].fqdn # Application URL
}

output "azurerm_container_app_url_latest" {
  value = azurerm_container_app.ca.latest_revision_fqdn # Latest revision URL that changes
}

output "azurerm_container_app_revision_name" {
  value = azurerm_container_app.ca.latest_revision_name
}

# Output Entra ID App Registration / Service Principal Secret

output "azuread_application_reg_object_id" {
  value = azuread_application_registration.oai_app_reg.id
}

output "azuread_application_reg_client_id" {
  value = azuread_application_registration.oai_app_reg.client_id
}

output "azuread_application_password" {
  value       = azuread_application_password.oai_app_pass.value
  description = "Output App Registration secret"
  sensitive   = true
}

# Use the following to output the App Registration password to the console
# terraform output -raw azuread_application_password