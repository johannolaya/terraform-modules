output "cdn_profile_name" {
  value = "${azurerm_cdn_profile.cdn.name}"
}

output "endpoint_host_name" {
  value = "${azurerm_cdn_endpoint.cdn_ep.host_name}"
}

output "endpoint_host_name_slot" {
  value = "${azurerm_cdn_endpoint.cdn_ep_slot.host_name}"
}