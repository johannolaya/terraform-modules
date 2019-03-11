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

