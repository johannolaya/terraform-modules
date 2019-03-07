data "aws_route53_zone" "domain" {
  zone_id = "${var.aws_zone_id}"
  private_zone = true
}

resource "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  name                = "traffic${var.tm_name}"
  resource_group_name = "${var.rg_name}"

  traffic_routing_method = "${var.tm_routing_method}"

  dns_config {
    relative_name = "${var.tm_name}"
    ttl           = "${var.tm_ttl}"
  }

  monitor_config {
    protocol = "https"
    port     = 443
    path     = "/"
  }

}

resource "azurerm_traffic_manager_endpoint" "traffic_manager_endpoint" {
  name                = "${lookup(element(var.tm_apps,count.index%length(var.tm_apps)), "app_name")}"
  resource_group_name = "${var.rg_name}"
  profile_name        = "${azurerm_traffic_manager_profile.traffic_manager_profile.name}"
  target_resource_id  = "${lookup(element(var.tm_apps,count.index%length(var.tm_apps)), "app_id")}"
  type                = "azureEndpoints"
  weight              = 1
  priority            = 1
  count               = "${length(var.tm_apps)}"
  endpoint_location = "${var.location}"
}

resource "aws_route53_record" "aws-route" {
  zone_id = "${data.aws_route53_zone.domain.zone_id}"
  name = "${var.tm_app_dns}.${data.aws_route53_zone.domain.name}"
  type = "${var.aws_type}"
  ttl = "${var.aws_ttl}"
  records = [
    "${azurerm_traffic_manager_profile.traffic_manager_profile.fqdn}"]
  depends_on = ["azurerm_traffic_manager_endpoint.traffic_manager_endpoint"]
}