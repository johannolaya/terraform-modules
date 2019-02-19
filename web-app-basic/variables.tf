variable "rg_name" {
  description = "describe channel of product"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "name_prefix_g" {
  description = "unique part of the name to give to resources"
}

variable "channel_g" {
  description = "describe channel of product"
}

variable "location_g" {
  description = "region where the resources should exist"
}

variable "tier_sp" {
  description = "tier service plan product"
}

variable "size_sp" {
  description = "size service plan web app product"
}

variable "app_services_settings" {
  type = "map"
}

variable "app_services_slot_settings" {
  type = "map"
}

variable "connection_string" {
  description = "string conection database principal"
}

variable "instrumentation_key_app" {
  description = "string conection database principal"
}

variable "client_secret" {
  description = "string conection database principal"
}

variable "client_id" {
  description = "string conection database principal"
}

