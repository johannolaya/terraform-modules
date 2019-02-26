output "sendgrid_password" {
  value      = "${var.sendgrid["password"]}"
}

output "sendgrid_username" {
  value = "${azurerm_template_deployment.sendgrid.outputs["sendGrid"]}"
}
