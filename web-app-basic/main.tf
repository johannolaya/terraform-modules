resource "azurerm_app_service_plan" "sp" {
  name = "${var.location_g}-sp-${var.name_prefix_g}-${var.channel_g}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"

  sku {
    tier = "${var.tier_sp}"
    size = "${var.size_sp}"
  }
}

resource "azurerm_app_service" "app" {
  name = "${var.location_g}-app-${var.name_prefix_g}-${var.channel_g}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  app_service_plan_id = "${azurerm_app_service_plan.sp.id}"

  site_config {
    scm_type = "LocalGit"
    always_on = true
  }

  app_settings = "${merge(
    map("APPINSIGHTS_INSTRUMENTATIONKEY",var.instrumentation_key_app),
    map("setting06",var.client_secret),
    map("setting07",var.client_id),
    var.app_services_settings)}"

  connection_string {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "${var.connection_string}"
  }

  depends_on = [
    "azurerm_sql_database.db",
    "azurerm_storage_account.sa",
    "azurerm_application_insights.app_ins"]
}

terraform {
  backend "azurerm" {}
}
