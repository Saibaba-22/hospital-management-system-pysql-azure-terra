#public ip 
resource "azurerm_public_ip" "pip" {
    name = var.pip_name
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    allocation_method = "Static"
    sku                 = "Standard"

    tags = {
        environment = " production "
    }
    depends_on = [ azurerm_subnet.sub ]
}

#public ip 
resource "azurerm_public_ip" "pip2" {
    name = var.pip2_name
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    allocation_method = "Static"
    sku                 = "Standard"

    tags = {
        environment = " production "
    }
    depends_on = [ azurerm_subnet.sub ]
}