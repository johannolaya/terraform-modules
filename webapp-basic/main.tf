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
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  application_type = "Web"
}


variable "jabs" {
  type = "list"
  default = [
    {
      name = "fa5ec449-053f-493c-a592-9a30cfca0e4c"
      type = "SQLServer"
      value= "JABBABOSA"
    },
    {
      name = "4e59aa54-2a5e-4a36-bfc2-2c986ce66116"
      type = "SQLServer"
      value= "JABBABOSA"
    }
  ]
}

resource "azurerm_app_service" "app" {
  name = "${var.location}-app-${var.prefix_rs}-${var.channel_g}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  app_service_plan_id = "${azurerm_app_service_plan.sp.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type = "LocalGit"
    always_on = true
  }

  app_settings = "${merge(
    map("APPINSIGHTS_INSTRUMENTATIONKEY",local.app_instrumentation_key),
    map("setting06",var.client_secret),
    map("setting07",var.client_id),
    map("service_discovery_connection",var.sa_connection),
    var.app_settings)}"



  connection_string {
    name         = "${lookup(var.jabs[count.index], "name")}"
    type      = "${lookup(var.jabs[count.index], "type")}"
    value = "${lookup(var.jabs[count.index], "value")}"

  }
}

resource "azurerm_app_service_slot" "app_slot" {
  name = "slot"
  app_service_name = "${azurerm_app_service.app.name}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  app_service_plan_id = "${azurerm_app_service_plan.sp.id}"

  site_config {
    scm_type = "LocalGit"
    always_on = true
  }

  app_settings = "${merge(
    map("APPINSIGHTS_INSTRUMENTATIONKEY",local.app_instrumentation_key),
    map("setting05",var.client_secret),
    map("setting06",var.client_id),
    map("service_discovery_connection",var.sa_connection),
    var.app_settings_slot)}"

  connection_string {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "${var.db_connection_app_slot}"
  }
}

locals {
  app_instrumentation_key = "${azurerm_application_insights.app_insights.instrumentation_key}"
}

terraform {
  backend "azurerm" {}
}
