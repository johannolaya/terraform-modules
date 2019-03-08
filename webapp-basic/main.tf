resource "azurerm_app_service_plan" "sp" {
  name = "${var.location}-sp-${var.prefix_rs}-${var.channel_g}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"

  sku {
    tier = "${var.sp_tier}"
    size = "${var.sp_size}"
  }
}

resource "azurerm_application_insights" "app_insights" {
  name = "${var.location}-ins-${var.prefix_rs}-${var.channel_g}"
  location = "${var.app_insights_location}"
  resource_group_name = "${var.rg_name}"
  application_type = "Web"
}


resource "azurerm_app_service" "app" {
  name = "${var.location}-app-${var.prefix_rs}-${var.channel_g}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  app_service_plan_id = "${azurerm_app_service_plan.sp.id}"

  site_config {
    min_tls_version = "${var.app_tls_version}"
    dotnet_framework_version = "v4.0"
    scm_type = "LocalGit"
    always_on = true
    default_documents = "${var.app_default_documents}"
  }

  app_settings = "${merge(
    map("APPINSIGHTS_INSTRUMENTATIONKEY",local.app_instrumentation_key),
    map(var.app_insights_name ,local.app_instrumentation_key),
    var.app_settings)}"

  connection_string {
    name = "${lookup(var.connection_01, "name")}"
    type = "${lookup(var.connection_01, "type")}"
    value = "${lookup(var.connection_01, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_02, "name")}"
    type = "${lookup(var.connection_02, "type")}"
    value = "${lookup(var.connection_02, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_03, "name")}"
    type = "${lookup(var.connection_03, "type")}"
    value = "${lookup(var.connection_03, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_04, "name")}"
    type = "${lookup(var.connection_04, "type")}"
    value = "${lookup(var.connection_04, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_05, "name")}"
    type = "${lookup(var.connection_05, "type")}"
    value = "${lookup(var.connection_05, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_06, "name")}"
    type = "${lookup(var.connection_06, "type")}"
    value = "${lookup(var.connection_06, "value")}"
  }

  depends_on = ["azurerm_application_insights.app_insights"]

}

resource "azurerm_app_service_slot" "app_slot" {
  name = "slot"
  app_service_name = "${azurerm_app_service.app.name}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  app_service_plan_id = "${azurerm_app_service_plan.sp.id}"

  site_config {
    min_tls_version = "${var.app_tls_version}"
    scm_type = "LocalGit"
    always_on = true
    default_documents = "${var.app_default_documents}"
  }

  app_settings = "${merge(
    map("APPINSIGHTS_INSTRUMENTATIONKEY",local.app_instrumentation_key),
    map(var.app_insights_name, local.app_instrumentation_key),
    var.app_settings_slot)}"

  connection_string {
    name = "${lookup(var.connection_slot_01, "name")}"
    type = "${lookup(var.connection_slot_01, "type")}"
    value = "${lookup(var.connection_slot_01, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_slot_02, "name")}"
    type = "${lookup(var.connection_slot_02, "type")}"
    value = "${lookup(var.connection_slot_02, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_slot_03, "name")}"
    type = "${lookup(var.connection_slot_03, "type")}"
    value = "${lookup(var.connection_slot_03, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_slot_04, "name")}"
    type = "${lookup(var.connection_slot_04, "type")}"
    value = "${lookup(var.connection_slot_04, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_slot_05, "name")}"
    type = "${lookup(var.connection_slot_05, "type")}"
    value = "${lookup(var.connection_slot_05, "value")}"
  }

  connection_string {
    name = "${lookup(var.connection_slot_06, "name")}"
    type = "${lookup(var.connection_slot_06, "type")}"
    value = "${lookup(var.connection_slot_06, "value")}"
  }

  depends_on = ["azurerm_application_insights.app_insights","azurerm_app_service.app"]

}

locals {
  app_instrumentation_key = "${azurerm_application_insights.app_insights.instrumentation_key}"
}

