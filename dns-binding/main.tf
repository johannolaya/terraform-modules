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
