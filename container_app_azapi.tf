# Use azapi to configure Container App Authentication with a pre-created Identity Provider Entra ID App Registration (Azurerm does not have this functionality yet - July-06-2024)
# https://learn.microsoft.com/en-us/rest/api/containerapps/container-apps-auth-configs/create-or-update

resource "azapi_resource_action" "ca_app_auth" {
  type        = "Microsoft.App/containerApps/authConfigs@2024-03-01"
  resource_id = "${azurerm_container_app.ca.id}/authConfigs/current"
  method      = "PUT"

  body = jsonencode({
    location = azurerm_resource_group.oai_rg.location
    properties = {
      globalValidation = {
        redirectToProvider          = "azureactivedirectory"
        unauthenticatedClientAction = "RedirectToLoginPage"
      }
      identityProviders = {
        azureActiveDirectory = {
          registration = {
            clientId                = azuread_application_registration.oai_app_reg.client_id
            clientSecretSettingName = "microsoft-provider-authentication-secret"
            openIdIssuer            = "https://sts.windows.net/${data.azurerm_subscription.current.tenant_id}/v2.0"
          }
          validation = {
            defaultAuthorizationPolicy = {
              #allowedApplications = [
              #  azuread_application_registration.oai_app_reg.id,
              #]
            }
          }
        }
      }
      platform = {
        enabled = true
      }
    }
  })
  depends_on = [
    azurerm_container_app.ca,
    azuread_application_password.oai_app_pass,
  ]
}