resource "azurerm_app_service_plan" "sp" {
  name = "${var.location_g}-sp-${var.name_prefix_g}-${var.channel_g}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"

  sku {
    tier = "${var.tier_sp}"
    size = "${var.size_sp}"
  }
}

terraform {
  backend "azurerm" {}
}
