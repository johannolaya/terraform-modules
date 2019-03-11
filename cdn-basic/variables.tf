variable "rg_name" {
}

variable "location" {
}

variable "prefix_rs" {
}

variable "channel_g" {
}

variable "sku_name" {
}

variable "compression_enabled" {
  default=false
}

variable "content_types_to_compress" {
  type="list"
  default=[]
}

variable "app_dns" {
}

variable "aws_domain_bizagi" {
}

variable "origin_host_name" {
}

variable "origin_host_header" {
}

variable "origin_host_name_slot" {
}

variable "origin_host_header_slot" {
}
