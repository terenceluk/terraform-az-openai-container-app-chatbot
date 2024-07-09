/*
This file contains all the variables defined for the terraform code
Refer to terraform-{env}.tfvars for the actual value for these variables
*/

# Variables for Azure resource group

variable "rg_name" {
  type        = string
  description = "Configure the resource group name"
}

variable "rg_location" {
  type        = string
  description = "Configure the resource group location"
}

variable "environment" {
  type        = string
  description = "Configure the name for environment"
}

# Variables for Azure OpenAI

variable "oai_account_name" {
  type        = string
  description = "Configure the name for OpenAI"
}

variable "oai_application_name" {
  type        = string
  description = "Configure the application name for OpenAI"
}

variable "oai_custom_subdomain_name" {
  type        = string
  description = "Configure the custom domain name for OpenAI"
}

variable "oai_default_tags_enabled" {
  type        = bool
  description = "Configure the default tag for OpenAI"
}

variable "oai_model_deployment" {
  description = "Deployment settings for the OpenAI model"
  type = map(object({
    name          = string
    model_format  = string
    model_name    = string
    model_version = string
    scale_type    = string
  }))
}

variable "oai_dynamic_throttling_enabled" {
  type        = bool
  description = "Configure dynamic throttling for OpenAI"
}

variable "oai_environment" {
  type        = string
  description = "Configure the OpenAI environment"
}

variable "oai_identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  description = "Configure the type of identity for OpenAI"
}

variable "oai_local_auth_enabled" {
  type        = bool
  description = "Configure the local authentication for OpenAI"
}

variable "oai_outbound_network_access_restricted" {
  type        = bool
  description = "Configure the outbound network access for OpenAI"
}

variable "oai_public_network_access_enabled" {
  type        = bool
  description = "Configure the public network access for OpenAI"
}

variable "oai_sku_name" {
  type        = string
  description = "Configure the SKU for OpenAI"
}

variable "oai_tags" {
  type        = map(string)
  description = "Configure the tags for OpenAI"
}

# Log Analytics Workspace

variable "oai_log_analytics_workspace_name" {
  type        = string
  description = "Configure the log analytics workspace name for OpenAI"
}

variable "oai_log_analytics_workspace_sku" {
  type        = string
  description = "Configure the log analytics workspace sku for OpenAI"
}

variable "oai_log_analytics_workspace_retention" {
  type        = number
  description = "Configure the log analytics workspace retention for OpenAI"
}

variable "ca_log_analytics_workspace_name" {
  type        = string
  description = "Configure the log analytics workspace name for Container App"
}

variable "ca_log_analytics_workspace_sku" {
  type        = string
  description = "Configure the log analytics workspace sku for Container App"
}

variable "ca_log_analytics_workspace_retention" {
  type        = number
  description = "Configure the log analytics workspace retention for Container App"
}

# Container App

variable "container_app_env_name" {
  type        = string
  description = "Configure the name for Container App Environment"
}

variable "container_app_env_location" {
  type        = string
  description = "Configure the location for Container App"
}

variable "container_app_name" {
  type        = string
  description = "Configure the name for Container App"
}

variable "ca_revision_mode" {
  type        = string
  description = "Configure the revision mode for Container App"
}

# Azure Monitor Diagnostic Setting

variable "oai_diagnostic_name" {
  type        = string
  description = "Configure the Azure Monitor diagnostics name for OpenAI"
}

variable "oai_diagnostic_category_group" {
  type        = string
  description = "Configure the Azure Monitor category group for OpenAI"
}

variable "oai_diagnostic_metric" {
  type        = string
  description = "Configure the Azure Monitor diagnostics metric for OpenAI"
}

# Entra ID App Registration / Service Principal

variable "oai_entra_id_app_reg_name" {
  type        = string
  description = "Name used for the Entra ID app registration / service principal"
}

# Container App Container Configuration
variable "container_name" {
  type        = string
  description = "Container name"
}
variable "container_image" {
  type        = string
  description = "Container repository"
}

variable "container_cpu" {
  type        = number
  description = "Container vCPU"
}

variable "container_memory" {
  type        = string
  description = "Container memory"
}

# Container App Ingress Configuration
variable "ingress_external_enabled" {
  type        = bool
  description = "Container App Ingress configuration"
}

variable "ingress_target_port" {
  type        = number
  description = "Continer App Ingress target port"
}
variable "ingress_traffic_weight_percentage" {
  type        = number
  description = "Container App Ingress traffic weight"
}
variable "ingress_traffic_weight_latest_revision" {
  type        = bool
  description = "Container App Ingress traffic weight revision"
}

# Container App Container Environmental Variables
variable "OPENAI_API_TYPE" {
  type        = string
  description = "Container OpenAI API type"
}

variable "OPENAI_API_VERSION" {
  type        = string
  description = "Container OpenAI API version"
}

variable "AZURE_DEPLOYMENT_ID" {
  type        = string
  description = "Container OpenAI deployment ID"
}

variable "DEFAULT_MODEL" {
  type        = string
  description = "Container default OpenAI model"
}