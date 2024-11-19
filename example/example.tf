
locals {
  tags = {
    environment = "Production"
  }

  naming_convention_info = {
    site = "test"
    app = "web"
    env = "prod"
    name = "001"
  }

}

data "azurerm_client_config" "current" {}

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = local.tags
    }
  }
}

module "azurerm_key_vault" {
  source = "git::https://github.com/BrettOJ/tf-az-module-azure-key-vault?ref=main"
  resource_group_name = module.resource_groups.rg_output[1].name
  location            = var.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  enable_rbac_authorization       = true
  network_acls = {
      bypass                     = "AzureServices"
      default_action             = "Allow"
      ip_rules                   = null
      virtual_network_subnet_ids = null
  }
  purge_protection_enabled        = true
  public_network_access_enabled   = true
  soft_delete_retention_days      = 7
  tags                   = local.tags
  naming_convention_info = local.naming_convention_info
}

module "azurerm_key_vault_key" { 
  source = "git::https://github.com/BrettOJ/tf-az-module-key-vault-key?ref=main"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = var.key_type
  key_size     = var.key_size
  curve = var.curve
  key_opts = var.key_opts
  not_before_date = var.not_before_date
  expiration_date = var.expiration_date
  tags = local.tags
  naming_convention_info = local.naming_convention_info

  rotation_policy = {
    automatic = {
      time_before_expiry = var.rotation_policy_automatic_time_before_expiry
      time_after_creation = var.rotation_policy_automatic_time_after_creation
    }
    expire_after         = var.rotation_policy_expire_after
    notify_before_expiry = var.rotation_policy_notify_before_expiry
  }
}