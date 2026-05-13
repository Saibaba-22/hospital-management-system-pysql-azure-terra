resource "azurerm_linux_virtual_machine" "vm" {
#vm basic 
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.nic.id]

# VM size 
  os_disk {
    name = "myOSdisk1"
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
  computer_name  = "studentserver"
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
      "set -e",
        # 1. CREATE PARENT PROJECT DIRECTORY
        "sudo mkdir -p /home/SaiAzadmin/hospital-mgmt/backend/",
        "sudo mkdir -p /home/SaiAzadmin/hospital-mgmt/backend/app/routes",
        "sudo mkdir -p /home/SaiAzadmin/hospital-mgmt/frontend",

        # 2. CHANGE OWNER & PERMISSIONS
        "sudo chown -R SaiAzadmin:SaiAzadmin /home/SaiAzadmin/hospital-mgmt",
    ]
  }

# BACKEND FILES COPY Destination: /home/SaiAzadmin/hospital-mgmt/backend
provisioner "file" {
  source      = "./backend/app/__init__.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/app/__init__.py"
}

provisioner "file" {
  source      = "./backend/app/database.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/app/database.py"
}

provisioner "file" {
  source      = "./backend/app/routes/patients.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/app/routes/patients.py"
}

provisioner "file" {
  source      = "./backend/app/routes/doctors.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/app/routes/doctors.py"
}

provisioner "file" {
  source      = "./backend/app/routes/appointments.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/app/routes/appointments.py"
}

provisioner "file" {
  source      = "./backend/app/routes/departments.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/app/routes/departments.py"
}

provisioner "file" {
  source      = "./backend/app/routes/stats.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/app/routes/stats.py"
}

provisioner "file" {
  source      = "./backend/wsgi.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/wsgi.py"
}

provisioner "file" {
  source      = "./backend/gunicorn.conf.py"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/gunicorn.conf.py"
}

provisioner "file" {
  source      = "./backend/requirements.txt"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/requirements.txt"
}

provisioner "file" {
  source      = "./backend/.env"
  destination = "/home/SaiAzadmin/hospital-mgmt/backend/.env"
}

# FRONTEND FILES COPY Destination : /home/SaiAzadmin/hospital-mgmt/frontend
provisioner "file" {
  source      = "./frontend/index.html"
  destination = "/home/SaiAzadmin/hospital-mgmt/frontend/index.html"
}

provisioner "file" {
  source      = "./frontend/nginx.conf"
  destination = "/home/SaiAzadmin/hospital-mgmt/frontend/nginx.conf"
}


# Inside execute 
  provisioner "remote-exec" {
    inline = [
      "set -e",

      # Install dependencies
      "sudo apt update -y",
      "sudo apt install -y python3 python3-pip python3-venv",
      "sudo apt install -y nginx",

      "echo 'MYSQL_HOST=${azurerm_network_interface.nic2.private_ip_address}' >> /home/SaiAzadmin/hospital-mgmt/backend/.env",
      "echo 'MYSQL_DB=${var.db_name}' >> /home/SaiAzadmin/hospital-mgmt/backend/.env",
      "echo 'MYSQL_USER=${var.db_user}' >> /home/SaiAzadmin/hospital-mgmt/backend/.env",
      "echo 'MYSQL_PASSWORD=${var.db_password}' >> /home/SaiAzadmin/hospital-mgmt/backend/.env",
      "echo 'MYSQL_PORT=3306' >> /home/SaiAzadmin/hospital-mgmt/backend/.env",

      "cd /home/SaiAzadmin/hospital-mgmt/backend",

      "python3 -m venv venv",

      ". venv/bin/activate && pip install --upgrade pip",

      ". venv/bin/activate && pip install -r requirements.txt",

      "sudo cp /home/SaiAzadmin/hospital-mgmt/frontend/nginx.conf /etc/nginx/sites-available/hms",

      "sudo ln -sf /etc/nginx/sites-available/hms /etc/nginx/sites-enabled/hms",

      "sudo rm -f /etc/nginx/sites-enabled/default",

      "cd /home/SaiAzadmin/hospital-mgmt/backend",
      "nohup venv/bin/gunicorn -c gunicorn.conf.py app:app > backend.log 2>&1 &",

      # Backup original config
      "sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup",

      # Copy custom server block
      "sudo cp /home/SaiAzadmin/hospital-mgmt/frontend/nginx.conf /etc/nginx/conf.d/hospital.conf",

      # Test nginx
      "sudo nginx -t",

      # Enable on boot
      "sudo systemctl enable nginx",

      # Restart nginx
      "sudo systemctl restart nginx"
      ]
    }
}

/*
  provisioner "file" {
    content = templatefile("${path.module}/frontend/index.html", {
      vm_ip = self.public_ip_address
      } 
    )
    destination = "/home/SaiAzadmin/student-python/templates/index.html"
  }
*/