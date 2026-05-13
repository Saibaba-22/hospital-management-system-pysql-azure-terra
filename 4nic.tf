# nic card 
resource "azurerm_network_interface" "nic" {
    name = var.nic_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
      name = "internal"
      private_ip_address_allocation = "Dynamic" 
      subnet_id = azurerm_subnet.sub.id
      
      # for allocating public ip to nic card 
      public_ip_address_id = azurerm_public_ip.pip.id
    }
    depends_on = [ azurerm_public_ip.pip ]
}

# nic card 
resource "azurerm_network_interface" "nic2" {
    name = var.nic2_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
      name = "internal"
      private_ip_address_allocation = "Dynamic" 
      subnet_id = azurerm_subnet.sub2.id
      
      # for allocating public ip to nic card 
      public_ip_address_id = azurerm_public_ip.pip2.id
    }
    depends_on = [ azurerm_public_ip.pip2 ]
}
