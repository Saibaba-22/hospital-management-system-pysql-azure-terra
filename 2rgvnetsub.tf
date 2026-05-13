# resource group
resource "azurerm_resource_group" "rg" {
    name = var.rg_rgname
    location = var.rg_rgloc
}

# resource virtual network 
resource "azurerm_virtual_network" "vnet" {
    name = var.vnet_vnetname
    location = var.vnet_vnetloc 
    address_space = var.vnet_vnetip
    resource_group_name = azurerm_resource_group.rg.name
    depends_on = [ azurerm_resource_group.rg ]
}

# subnet 
resource "azurerm_subnet" "sub"{
    name = var.sub_subname 
    address_prefixes = var.sub_subip
    resource_group_name = azurerm_resource_group.rg.name 
    virtual_network_name = azurerm_virtual_network.vnet.name 
    depends_on = [ azurerm_virtual_network.vnet ]
}

resource "azurerm_subnet" "sub2"{
    name = var.sub2_subname 
    address_prefixes = var.sub2_subip
    resource_group_name = azurerm_resource_group.rg.name 
    virtual_network_name = azurerm_virtual_network.vnet.name 
    depends_on = [ azurerm_virtual_network.vnet ]
}


