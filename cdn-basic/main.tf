resource "azurerm_cdn_profile" "cdn" {
  name = "${var.location}-cdn-${var.prefix_rs}-${var.channel_g}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  sku                 = "${var.sku_name}"
}

resource "azurerm_cdn_endpoint" "cdn_ep" {
  name                = "${var.location}-ep-${var.prefix_rs}-${var.channel_g}"
  profile_name        = "${azurerm_cdn_profile.cdn.name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  is_compression_enabled = "${var.compression_enabled}"
  content_types_to_compress = "${var.content_types_to_compress}"

  origin {
    name      = "${var.location}-ori-${var.prefix_rs}-${var.channel_g}"
    host_name = "${var.origin_host_name}"
  }
  origin_host_header = "${var.origin_host_header}"
}

resource "azurerm_cdn_endpoint" "cdn_ep_slot" {
  name                = "${var.location}-ep-${var.prefix_rs}-${var.channel_g}-slot"
  profile_name        = "${azurerm_cdn_profile.cdn.name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  is_compression_enabled = "${var.compression_enabled}"
  content_types_to_compress = "${var.content_types_to_compress}"

  origin {
    name      = "${var.location}-ori-${var.prefix_rs}-${var.channel_g}-slot"
    host_name = "${var.origin_host_name}"
  }
  origin_host_header= "${var.origin_host_header}"
}