resource "azurerm_key_vault" "kv" {
  name                = "secure-app-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  public_network_access_enabled = false

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }

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

import {
  to = azurerm_key_vault.kv
  id = "/subscriptions/77c31ba8-e2cd-4fa2-84a7-766748b0b30d/resourceGroups/secure-app-starter-rg/providers/Microsoft.KeyVault/vaults/secure-app-kv"
}