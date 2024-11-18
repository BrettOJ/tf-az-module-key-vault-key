
key_size = 2048
key_type = "RSA"
curve = "P-256"
not_before_date = "2023-11-01T12:00:00Z"
expiration_date = "2025-11-01T12:00:00Z"
key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  rotation_policy_automatic_time_before_expiry = "P30D"
  rotation_policy_expire_after = "P90D"
  rotation_policy_notify_before_expiry = "2020-08-01T12:00:00Z"

