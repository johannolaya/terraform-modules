 locals {
  local_db_name = "${var.db_name != "" ? var.db_name : ${var.prefix_rs}-db-${var.channel_g}"
}
 
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

  resource "azurerm_sql_firewall_rule" "ip-azure-services" {
    name = "AllowAllAzureService"
    resource_group_name = "${var.rg_name}"
    server_name = "${azurerm_sql_server.sdb.name}"
    start_ip_address = "0.0.0.0"
    end_ip_address = "0.0.0.0"
  }

 resource "azurerm_sql_firewall_rule" "ip-custom-services" {
   name = "${element(keys(var.sdb_firewall_ips), count.index)}"
   count="${length(keys(var.sdb_firewall_ips))}"
   resource_group_name = "${var.rg_name}"
   server_name = "${azurerm_sql_server.sdb.name}"
   start_ip_address = "${element(values(var.sdb_firewall_ips), count.index)}"
   end_ip_address = "${element(values(var.sdb_firewall_ips), count.index)}"
 }

  resource "azurerm_sql_database" "db" {
    name = "${local.local_db_name}"
    resource_group_name = "${var.rg_name}"
    location = "${var.location}"
    server_name = "${azurerm_sql_server.sdb.name}"
    requested_service_objective_name = "${var.db_size}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }
  resource "azurerm_sql_database" "db_slot" {
    name = "${local.local_db_name}-slot"
    resource_group_name = "${var.rg_name}"
    location = "${var.location}"
    server_name = "${azurerm_sql_server.sdb.name}"
    requested_service_objective_name = "${var.db_size_slot}"
    depends_on = [
      "azurerm_sql_server.sdb"]
  }

