terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

  provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "secure-app-starter-rg"
  location = "francecentral"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "secure-app-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

import {
  to = azurerm_resource_group.rg
  id = "/subscriptions/77c31ba8-e2cd-4fa2-84a7-766748b0b30d/resourceGroups/secure-app-starter-rg"
}

import {
  to = azurerm_virtual_network.vnet
  id = "/subscriptions/77c31ba8-e2cd-4fa2-84a7-766748b0b30d/resourceGroups/secure-app-starter-rg/providers/Microsoft.Network/virtualNetworks/secure-app-vnet"
}

import {
  to = azurerm_subnet.default
  id = "/subscriptions/77c31ba8-e2cd-4fa2-84a7-766748b0b30d/resourceGroups/secure-app-starter-rg/providers/Microsoft.Network/virtualNetworks/secure-app-vnet/subnets/default"
}

import {
  to = azurerm_network_security_group.nsg
  id = "/subscriptions/77c31ba8-e2cd-4fa2-84a7-766748b0b30d/resourceGroups/secure-app-starter-rg/providers/Microsoft.Network/networkSecurityGroups/secure-app-nsg"
}

import {
  to = azurerm_subnet_network_security_group_association.nsg_assoc
  id = "/subscriptions/77c31ba8-e2cd-4fa2-84a7-766748b0b30d/resourceGroups/secure-app-starter-rg/providers/Microsoft.Network/virtualNetworks/secure-app-vnet/subnets/default"
}