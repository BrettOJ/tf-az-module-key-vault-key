resource "azurerm_key_vault_key" "akv_key" {
  name         = module.akv_name.naming_convention_output[var.naming_convention_info.name].names.0
  key_vault_id = var.key_vault_id
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts = var.key_opts

  rotation_policy {
    automatic {
      time_before_expiry = var.rotation_policy.automatic.time_before_expiry
    }

    expire_after         = var.rotation_policy.expire_after
    notify_before_expiry = var.rotation_policy.notify_before_expiry
  }
}