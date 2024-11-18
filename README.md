Manages a Key Vault Key.

## [Example Usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage)

## [Example Usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage-1)

```hcl
provider "azurerm" { features { key_vault { purge_soft_deleted_keys_on_destroy = true recover_soft_deleted_keys = true } } } data "azurerm_client_config" "current" {} resource "azurerm_resource_group" "example" { name = "example-resources" location = "West Europe" } resource "azurerm_key_vault" "example" { name = "examplekeyvault" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name tenant_id = data.azurerm_client_config.current.tenant_id sku_name = "premium" soft_delete_retention_days = 7 access_policy { tenant_id = data.azurerm_client_config.current.tenant_id object_id = data.azurerm_client_config.current.object_id key_permissions = [ "Create", "Delete", "Get", "Purge", "Recover", "Update", "GetRotationPolicy", "SetRotationPolicy" ] secret_permissions = [ "Set", ] } } resource "azurerm_key_vault_key" "generated" { name = "generated-certificate" key_vault_id = azurerm_key_vault.example.id key_type = "RSA" key_size = 2048 key_opts = [ "decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey", ] rotation_policy { automatic { time_before_expiry = "P30D" } expire_after = "P90D" notify_before_expiry = "P29D" } }
```

## [Argument Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#argument-reference)

The following arguments are supported:

-   [`name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#name) - (Required) Specifies the name of the Key Vault Key. Changing this forces a new resource to be created.
    
-   [`key_vault_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#key_vault_id) - (Required) The ID of the Key Vault where the Key should be created. Changing this forces a new resource to be created.
    
-   [`key_type`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#key_type) - (Required) Specifies the Key Type to use for this Key Vault Key. Possible values are `EC` (Elliptic Curve), `EC-HSM`, `RSA` and `RSA-HSM`. Changing this forces a new resource to be created.
    
-   [`key_size`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#key_size) - (Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. _Note_: This field is required if `key_type` is `RSA` or `RSA-HSM`. Changing this forces a new resource to be created.
    
-   [`curve`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#curve) - (Optional) Specifies the curve to use when creating an `EC` key. Possible values are `P-256`, `P-256K`, `P-384`, and `P-521`. This field will be required in a future release if `key_type` is `EC` or `EC-HSM`. The API will default to `P-256` if nothing is specified. Changing this forces a new resource to be created.
    
-   [`key_opts`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#key_opts) - (Required) A list of JSON web key operations. Possible values include: `decrypt`, `encrypt`, `sign`, `unwrapKey`, `verify` and `wrapKey`. Please note these values are case sensitive.
    
-   [`not_before_date`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#not_before_date) - (Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    

-   [`expiration_date`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#expiration_date) - (Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z'). When this parameter gets changed on reruns, if newer date is ahead of current date, an update is performed. If the newer date is before the current date, resource will be force created.
    
-   [`tags`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#tags) - (Optional) A mapping of tags to assign to the resource.
    
-   [`rotation_policy`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#rotation_policy) - (Optional) A `rotation_policy` block as defined below.
    

___

A `rotation_policy` block supports the following:

-   [`expire_after`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#expire_after) - (Optional) Expire a Key Vault Key after given duration as an [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations).
    
-   [`automatic`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#automatic) - (Optional) An `automatic` block as defined below.
    
-   [`notify_before_expiry`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#notify_before_expiry) - (Optional) Notify at a given duration before expiry as an [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations).
    

___

An `automatic` block supports the following:

-   [`time_after_creation`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#time_after_creation) - (Optional) Rotate automatically at a duration after create as an [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations).
    
-   [`time_before_expiry`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#time_before_expiry) - (Optional) Rotate automatically at a duration before expiry as an [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations).
    

## [Attributes Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference)

In addition to the Arguments listed above - the following Attributes are exported:

-   [`id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#id) - The Key Vault Key ID.
-   [`resource_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#resource_id) - The (Versioned) ID for this Key Vault Key. This property points to a specific version of a Key Vault Key, as such using this won't auto-rotate values if used in other Azure Services.
-   [`resource_versionless_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#resource_versionless_id) - The Versionless ID of the Key Vault Key. This property allows other Azure Services (that support it) to auto-rotate their value when the Key Vault Key is updated.
-   [`version`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#version) - The current version of the Key Vault Key.
-   [`versionless_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#versionless_id) - The Base ID of the Key Vault Key.
-   [`n`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#n) - The RSA modulus of this Key Vault Key.
-   [`e`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#e) - The RSA public exponent of this Key Vault Key.
-   [`x`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#x) - The EC X component of this Key Vault Key.
-   [`y`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#y) - The EC Y component of this Key Vault Key.
-   [`public_key_pem`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#public_key_pem) - The PEM encoded public key of this Key Vault Key.
-   [`public_key_openssh`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#public_key_openssh) - The OpenSSH encoded public key of this Key Vault Key.

## [Timeouts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#timeouts)

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

-   [`create`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#create) - (Defaults to 30 minutes) Used when creating the Key Vault Key.
-   [`update`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#update) - (Defaults to 30 minutes) Used when updating the Key Vault Key.
-   [`read`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#read) - (Defaults to 30 minutes) Used when retrieving the Key Vault Key.
-   [`delete`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#delete) - (Defaults to 30 minutes) Used when deleting the Key Vault Key.

## [Import](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#import)

Key Vault Key which is Enabled can be imported using the `resource id`, e.g.

```shell
terraform import azurerm_key_vault_key.example "https://example-keyvault.vault.azure.net/keys/example/fdf067c93bbb4b22bff4d8b7a9a56217"
```