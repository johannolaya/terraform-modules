data "template_file" "send_grid" {
  template = "${file("sendgrid.json")}"

  vars {
    location = "${var.location}"
    sendgrid_account_name = "${var.location}-sg-${var.prefix_rs}-${var.channel_g}"
    sendgrid_account_password = "${var.sendgrid["password"]}"
    sendgrid_contact_firstName = "${var.sendgrid["first_name"]}"
    sendgrid_contact_lastName = "${var.sendgrid["last_name"]}"
    sendgrid_company = "${var.sendgrid["company_name"]}"
    sendgrid_account_email = "${var.sendgrid["email"]}"
    sendgrid_plan_name= "${var.sendgrid["plan_name"]}"
  }
}

resource "azurerm_template_deployment" "sendgrid" {
  name = "${var.location}-arm-sg-${var.prefix_rs}-${var.channel_g}"
  resource_group_name = "${var.rg_name}"
  deployment_mode = "Incremental"
  template_body = "${data.template_file.send_grid.rendered}"
}