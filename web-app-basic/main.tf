resource "azurerm_resource_group" "rg" {
  name = "${var.location_g}-${var.name_prefix_g}-rg-${var.channel_g}"
  location = "${var.location_g}"
}

locals {
  resourcegroup = "${var.location_g}-app-${var.name_prefix_g}-${var.channel_g}"
}

terraform {
  backend "azurerm" {}
}


