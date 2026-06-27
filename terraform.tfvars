rgnames ={
    rg12 = {
        name = "vaibsrg"
        location = "eastus"
    }
}

stgnames = {
    stg12 = {
        name = "vaibstg"
        resource_group_name = "rg1"
        location = "eastus"
        account_tier = "Standard"
        account_replication_type = "LRS"
    }
}

vnetnames = {
    vnetg1 = {
        name = "vaibsvnet"
        resource_group_name = "rg1"
        location = "eastus"
        address_space = ["10.0.0.0/24"]
    }
}

subnetnames = {
    subnet1 = {
        name = "vaibssubnet"
        resource_group_name = "rg1"
        virtual_network = "vnetg1"
        adrress_prefixes = ["10.0.0.0/25"]
    }
    subnet2 = {
        name = "vaibssubnet2"
        resource_group_name = "rg1"
        virtual_network = "vnetg1"
        address_prefixes = ["10.0.0.0/25"]
    }
}

pipnames = {
    pipdemo1 = {
        name = "vaibspip"
        resource_group_name = "rg1"
        location = "eastus"
        allocation_method = "Static"
        sku = "Standard"
    }
}

nicnames = {
  nic1 = {
    name                          = "vm-nic1"
    resource_group_name           = "rg1"
    subnet_name                   = "subnet1"
    public_ip_name                = "pipdemo1"
    ip_configuration_name         = "internal"
    private_ip_address_allocation = "Dynamic"
  }
}

vmnames = {
    vaibsvm1 = {
        name = "vaibhavvm1"
        resource_group_name = "rg1"
        location = "eastus"
        size = "Standard_D2s_v3"
        admin_username = "azureuser"
        admin_password = "password@123"
        network_interface_id = "nic1"
    os_disk = {
        os1 = {
            caching = "Readwirte"
            storage_account_type = "Standara_LRS"
        }
    source_image_publisher = {
        image1 = {
            publisher = "Canonical"
            offer     = "0001-com-ubuntu-server-jammy"
            sku       = "22_04-lts"
            version   = "latest"
        }
    }    
    }
    }
    vaibsvm2 = {
        name = "vaibhavvm2"
        resource_group_name = "rg1"
        location = "eastus"
        size = "Standard_D2s_v3"
        admin_username = "azureuser"
        admin_password = "password@1234"
        network_interface_id = "nic1"
    }
    os_disk = {
        os1 = {
            caching = "Readwirte"
            storage_account_type = "Standara_LRS"
        }
    }    
    source_image_publisher = {
        image1 = {
            publisher = "Canonical"
            offer     = "0001-com-ubuntu-server-jammy"
            sku       = "22_04-lts"
            version   = "latest"
    }

}
}
