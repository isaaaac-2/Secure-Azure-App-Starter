resource "azurerm_key_vault" "kv" {
  name                = "secure-app-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "example" {
  name         = "db-password"
  value        = "super-secret-value-123"
  key_vault_id = azurerm_key_vault.kv.id
}