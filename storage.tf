resource "azurerm_storage_account" "sa" {
  name                     = "secureappsa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false
  shared_access_key_enabled       = false

  blob_properties {
    versioning_enabled = true
  }

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 7
    }
  }

  sas_policy {
    expiration_period = "30.00:00:00"
    expiration_action = "Log"
  }

  infrastructure_encryption_enabled = true
}