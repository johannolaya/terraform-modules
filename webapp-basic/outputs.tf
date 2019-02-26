output "sp_name" {
  value = "${azurerm_app_service_plan.sp.name}"
}

output "app_name" {
  value = "${azurerm_app_service.app.name}"
}

output "app_slot_name" {
  value = "${azurerm_app_service_slot.app_slot.name}"
}

output "sp_id" {
  value = "${azurerm_app_service_plan.sp.id}"
}