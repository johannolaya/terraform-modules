 resource "azurerm_sql_server" "sdb" {
    name = "${var.location}-sdb-${var.prefix_rs}-${var.channel_g}"
    resource_group_name = "${var.rg_name}"
    location = "${var.location}"
    version = "12.0"
    administrator_login = "${var.db_user}"
    administrator_login_password = "${var.db_password}"

    tags {
      environment = "${var.prefix_rs}"
    }
  }
  resource "azurerm_sql_firewall_rule" "ip-bizagi" {
    name = "FirewallRuleBizagi"
    resource_group_name = "${var.rg_name}"
    server_name = "${azurerm_sql_server.sdb.name}"
    start_ip_address = "${var.sdb_ip_bizagi}"
    end_ip_address = "${var.sdb_ip_bizagi}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }
  resource "azurerm_sql_firewall_rule" "ip-portal" {
    name = "FirewallRuePortal"
    resource_group_name = "${var.rg_name}"
    server_name = "${azurerm_sql_server.sdb.name}"
    start_ip_address = "${var.sdb_ip_portal}"
    end_ip_address = "${var.sdb_ip_portal}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }
  resource "azurerm_sql_firewall_rule" "ip-azure-services" {
    name = "AllowAllAzureService"
    resource_group_name = "${var.rg_name}"
    server_name = "${azurerm_sql_server.sdb.name}"
    start_ip_address = "0.0.0.0"
    end_ip_address = "0.0.0.0"
  }
  resource "azurerm_sql_database" "db" {
    name = "${var.prefix_rs}-db-${var.channel_g}"
    resource_group_name = "${var.rg_name}"
    location = "${var.location}"
    server_name = "${azurerm_sql_server.sdb.name}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }
  resource "azurerm_sql_database" "db_slot" {
    name = "${var.prefix_rs}-db-${var.channel_g}-slot"
    resource_group_name = "${var.rg_name}"
    location = "${var.location}"
    server_name = "${azurerm_sql_server.sdb.name}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }
  terraform {
  backend "azurerm" {}
}

