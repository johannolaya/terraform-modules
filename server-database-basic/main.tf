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

  resource "azurerm_sql_firewall_rule" "bizagiacces" {
    name = "FirewallRuleBizagi"
    resource_group_name = "${var.rg_name}"
    server_name = "${azurerm_sql_server.sdb.name}"
    start_ip_address = "${var.start_ip_address_sdb_biz}"
    end_ip_address = "${var.start_ip_address_sdb_biz}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }

  resource "azurerm_sql_firewall_rule" "jenkinsaccess" {
    name = "FirewallRueJenkins"
    resource_group_name = "${var.rg_name}"
    server_name = "${azurerm_sql_server.sdb.name}"
    start_ip_address = "${var.start_ip_address_sdb_jenkins}"
    end_ip_address = "${var.start_ip_address_sdb_jenkins}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }

  resource "azurerm_sql_firewall_rule" "portalaccess" {
    name = "FirewallRuePortal"
    resource_group_name = "${var.rg_name}"
    server_name = "${azurerm_sql_server.sdb.name}"
    start_ip_address = "${var.start_ip_address_sdb_portal}"
    end_ip_address = "${var.start_ip_address_sdb_portal}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }

  resource "azurerm_sql_firewall_rule" "azure_services" {
    name = "AllowAllAzureService"
    resource_group_name = "${var.rg_name}"
    server_name = "${azurerm_sql_server.sdb.name}"
    start_ip_address = "0.0.0.0"
    end_ip_address = "0.0.0.0"
  }

  resource "azurerm_sql_database" "db" {
    name = "${var.name_prefix_g}-db-${var.channel_g}"
    resource_group_name = "${var.rg_name}"
    location = "${var.location}"
    server_name = "${azurerm_sql_server.sdb.name}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }

  resource "azurerm_sql_database" "db_slot" {
    name = "${var.name_prefix_g}-db-${var.channel_g}-slot"
    resource_group_name = "${var.rg_name}"
    location = "${var.location}"
    server_name = "${azurerm_sql_server.sdb.name}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }

  terraform {
  backend "azurerm" {}
}

