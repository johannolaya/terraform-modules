output "connection_string" {
  value = "Server=tcp:${azurerm_sql_server.sdb.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.db.name};Persist Security Info=False;User ID=${azurerm_sql_server.sdb.administrator_login};Password=${azurerm_sql_server.sdb.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}

output "connection_string_slot" {
  value = "Server=tcp:${azurerm_sql_server.sdb.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.db_slot.name};Persist Security Info=False;User ID=${azurerm_sql_server.sdb.administrator_login};Password=${azurerm_sql_server.sdb.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}
