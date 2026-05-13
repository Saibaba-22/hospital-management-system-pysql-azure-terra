resource "azurerm_linux_virtual_machine" "vm2" {
#vm11 basic 
  name                = var.vm2_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.nic2.id]

# vm1 size 
  os_disk {
    name = "myOSdisk2"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

# OS 
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

# authentication 
  computer_name  = "dataserver"
  admin_username = var.username
  disable_password_authentication = false 
  admin_password = var.password 

  connection {
      type        = "ssh"
      user        = var.username
      password    = var.password
      host        = self.public_ip_address
    }

provisioner "remote-exec" {
  inline = [

    # UPDATE VM
    "sudo apt update -y",

    # INSTALL MYSQL SERVER
    "sudo apt install mysql-server -y",

    # START MYSQL
    "sudo systemctl start mysql",
    "sudo systemctl enable mysql",

    # CREATE DATABASE
    "sudo mysql -e \"CREATE DATABASE ordinary12345123;\"",

    # CREATE MYSQL USER
    "sudo mysql -e \"CREATE USER 'studentdb'@'localhost' IDENTIFIED BY 'Database123';\"",

    # GRANT PRIVILEGES
    "sudo mysql -e \"GRANT ALL PRIVILEGES ON ordinary12345123.* TO 'studentdb'@'localhost';\"",

    # APPLY PRIVILEGES
    "sudo mysql -e \"FLUSH PRIVILEGES;\"",

    # BIND MYSQL TO 0.0.0.0
    "sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf",


  ]
}
}
/*
  provisioner "file" {
    content = templatefile("${path.module}/frontend/index.html", {
      vm1_ip = self.public_ip_address
      } 
    )
    destination = "/home/SaiAzadmin/student-python/templates/index.html"
  }
*/