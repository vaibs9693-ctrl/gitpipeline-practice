terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "4.71.0"
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg1" {
    for_each = var.rgnames
    name = each.key
    location = each.value.location
}

resource "azurerm_storage_account"  "stg1" {
    for_each = var.stgnames
    name = each.value.name
    resource_group_name = azurerm_resource_group.rg1[each.value.resource_group_name].name
    location = azurerm_resource_group.rg1[each.value.resource_group_name].location
    account_tier = each.value.account_tier
    account_replication_type = each.value.account_replication_type
}

resource "azurerm_virtual_network" "vnet21" {
    for_each = var.vnetnames
    name = each.value.name
    resource_group_name = azurerm_resource_group.rg1[each.value.resource_group_name].name
    location = each.value.location
    address_space = each.value.address_space
}

resource "azurerm_subnet" "subnet11" {
    for_each = var.subnetnames
    name = each.value.name
    resource_group_name = azurerm_resource_group.rg1[each.value.resource_group_name].name
    virtual_network_name = azurerm_virtual_network.vnet21[each.value.virtual_network_name].name
    address_prefixes = each.value.address_prefixes
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg1["rg1"].name
  virtual_network_name = azurerm_virtual_network.vnet21["vnet1"].name
  address_prefixes     = ["10.0.10.0/26"]
}

resource "azurerm_public_ip" "pip21" {
    for_each = var.pipnames 
    name = each.value.name
    resource_group_name = azurerm_resource_group.rg1[each.value.resource_group_name].name
    location = azurerm_resource_group.rg1[each.value.resource_group_name].location

    allocation_method = each.value.allocation_method
    sku = each.value.sku
}
resource "azurerm_network_interface" "nic21" {
    for_each = var.nicnames
    name = each.value.name
    resource_group_name = azurerm_resource_group.rg1[each.value.resource_group_name].name
    location = azurerm_resource_group.rg1[each.value.resource_group_name].location

    ip_configuration {
        
    
        name = each.value.ip_configuration
        subnet_id = azurerm_subnet.subnet11[each.value.subnet_name].id
        private_ip_address_allocation = each.value.private_ip_address_allocation
        public_ip_address_id = azurerm_public_ip.pip[each.value.public_ip_name].id
        }
    }

resource "virtual_machine" "vmdemo1" {
    for_each = var.vmnames
    name = each.value.name
    resource_group_name = azurerm_resource_group.rg1[each.value.resource_group_name].name
    location = azurerm_resource_group.rg1[each.value.resource_group_name].location

    size = each.value.size
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password

    disable_password_authentication = false
    network_interface_ids = [
    azurerm_network_interface.nic21[each.value.nic_name].id
  ]

    dynamic os_disk {
        for_each = var.os_disk
        content {
            caching = each.value.os_disk.caching
            storage_account_type = each.value.os_disk.storage_account_type
        }
    }
    dynamic source_image_reference {
        for_each = var.source_image_reference
        content {
            publisher = each.value.source_image_reference.publisher
            offer = each.value.source_image_reference.offer
            sku = each.value.source_image_reference.sku
            version = each.value.source_image_reference.version
        }

    }
}    
