variable "rg_name" {
}

variable "location" {
}

variable "prefix_rs" {
}

variable "channel_g" {
}

variable "aws_zone_id" {

}

variable "aws_type" {

}

variable "aws_ttl" { }

variable "tm_name" {}

variable "tm_routing_method" {
  default="Performance"
}

variable "tm_apps_count" {
  default="3"
}

variable "tm_ttl" {
  default=300
}

variable "tm_app_dns" {
}

variable "tm_apps" {
  type="list"
}