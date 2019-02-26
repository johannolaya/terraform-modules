data "aws_route53_zone" "domain" {
  zone_id = "${var.aws_zone_id}"
  private_zone = true
}


resource "aws_route53_record" "aws-route" {
  zone_id = "${data.aws_route53_zone.domain.zone_id}"
  name = "${var.app_dns}.${data.aws_route53_zone.domain.name}"
  type = "${var.aws_type}"
  ttl = "${var.aws_ttl}"
  records = [
    "${var.app_url}.azurewebsites.net"]
}

resource "aws_route53_record" "aws-route-slot" {
  zone_id = "${data.aws_route53_zone.domain.zone_id}"
  name = "${var.app_dns}slot.${data.aws_route53_zone.domain.name}"
  type = "${var.aws_type}"
  ttl = "${var.aws_ttl}"
  records = [
    "${var.app_url}-slot.azurewebsites.net"]

}

data "template_file" "ssl_binding" {
  template = "${file("ssl_binding.json")}"
  vars {
    service_plan_id = "${var.sp_id}"
    app_service_name = "${var.app_name}/${var.app_dns}.${var.aws_domain_bizagi}"
    app_service_slot_name = "${var.app_name}/slot/${var.app_dns}slot.${var.aws_domain_bizagi}"
    key_vault_id = "${var.key_vault_id}"
  }
}

resource "azurerm_template_deployment" "ssl_binding" {
  name = "${var.location}-app-service-binding-${var.channel_g}"
  resource_group_name = "${var.rg_name}"
  deployment_mode = "Incremental"
  template_body = "${data.template_file.ssl_binding.rendered}"
  depends_on = [
    "aws_route53_record.aws-route",
    "aws_route53_record.aws-route-slot"
  ]
}

