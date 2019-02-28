output "sa_connection" {
  value = "${azurerm_storage_account.sa.primary_connection_string}"
}

output "sa_name" {
  value = "${azurerm_storage_account.sa.name}"
}

output "sa_key" {
  value = "${azurerm_storage_account.sa.primary_access_key}"
}