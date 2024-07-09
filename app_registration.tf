# Create and configure an Entra ID Application / Service Principal

# Create App Registration
resource "azuread_application_registration" "oai_app_reg" {
  display_name                       = var.oai_entra_id_app_reg_name
  implicit_id_token_issuance_enabled = true
  depends_on = [
  ]
}

# # Configure App Registration Web Redirect URIs
resource "azuread_application_redirect_uris" "oai_app_reg_web" {
  application_id = azuread_application_registration.oai_app_reg.id
  type           = "Web"

  redirect_uris = [
    "https://${azurerm_container_app.ca.ingress[0].fqdn}/.auth/login/aad/callback",
  ]
  depends_on = [
    azurerm_container_app.ca,
  ]
}

# Configure App Registration API Permissions

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

resource "azuread_application_api_access" "oai_app_reg_app_permissions" {
  application_id = azuread_application_registration.oai_app_reg.id
  api_client_id  = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]

  role_ids = []

  scope_ids = [
    data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"],
  ]

}

# Add Expose an API Application ID URI for the App Registration
resource "azuread_application_identifier_uri" "oai_app_reg_app_id_uri" {
  application_id = azuread_application_registration.oai_app_reg.id
  identifier_uri = "api://${azuread_application_registration.oai_app_reg.client_id}"
}

# Add Expose an API - Scope for the App Registration
resource "random_uuid" "administer" {}

resource "azuread_application_permission_scope" "oai_app_reg_scope" {
  application_id             = azuread_application_registration.oai_app_reg.id
  scope_id                   = random_uuid.administer.id
  value                      = "api://${azuread_application_registration.oai_app_reg.client_id}"
  admin_consent_description  = "Access ${var.container_app_name}"
  admin_consent_display_name = "Access ${var.container_app_name}"
  user_consent_description   = "Access ${var.container_app_name}"
  user_consent_display_name  = "Access ${var.container_app_name}"
}

# Create App Registration Secret
resource "azuread_application_password" "oai_app_pass" {
  application_id = azuread_application_registration.oai_app_reg.id
  depends_on = [
    azuread_application_registration.oai_app_reg,
  ]
}

# Create Enterprise Application
resource "azuread_service_principal" "oai_service_principal_reg" {
  client_id = azuread_application_registration.oai_app_reg.client_id
  depends_on = [
    azuread_application_password.oai_app_pass,
  ]
}

# Get current subscription's tenant ID for configuring Container App Registration
data "azurerm_subscription" "current" {
}
