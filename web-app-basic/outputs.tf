output "resource_gropu" {
  value = "${azurerm_resource_group.rg.name}"
}

output "name_prefix_g" {
  value = "${var.name_prefix_g}"
}
