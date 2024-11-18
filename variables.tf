variable "key_vault_id" {
  description = "The ID of the Key Vault where the Key should be created."
  type = string
}

variable "key_type" {
  description = "Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM."
  type = string
}

variable "key_size" {
  description = "Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM."
  type = number
    default = 2048
}

variable "curve" {
  description = "Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified."
  type = string
}

variable "key_opts" {
  description = "A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive."
  type = list(string)
}

variable "not_before_date" {
  description = "Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')."
  type = string
}

variable "expiration_date" {
  description = "Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."
  type = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type = map(string)
}

variable "rotation_policy" {
  description = "A rotation_policy block as defined below."
  type = object({
    expire_after = string
    automatic = object({
      time_after_creation = string
      time_before_expiry = string
    })
    notify_before_expiry = string
  })
}

variable naming_convention_info {
  description = "A map of naming convention information."
  type = map(string)
}