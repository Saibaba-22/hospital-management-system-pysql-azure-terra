output "nginx_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

/*
# SQL ENDPOINT
output "mysql_server_name" {
  value = azurerm_mysql_flexible_server.mysql.name
}

output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.mysql.fqdn
}

output "database_name" {
  value = azurerm_mysql_flexible_database.appdb.name
}

# DB Name
output "administrator_login" {
  value = azurerm_mysql_flexible_server.mysql.administrator_login
}
*/