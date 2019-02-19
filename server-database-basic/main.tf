
resource "azurerm_sql_server" "sdb" {
  name = "${var.location}-sdb-${var.name_prefix_g}-${var.channel_g}"
  resource_group_name = "${var.rg_name}"
  location = "${var.location}"
  version = "12.0"
  administrator_login = "${var.admin_username_db}"
  administrator_login_password = "${var.admin_password_db}"

  tags {
    environment = "${var.name_prefix_g}"
  }
}

