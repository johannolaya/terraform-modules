variable "prefix_rs" {
}

variable "channel_g" {
}

variable "rg_name" {
}

variable "location" {
}

variable "db_user" {
}

variable "db_password" {
}

variable "db_name" {
  default=""
}

variable "db_size" {
  default = "S0"
}

variable "db_size_slot" {
  default = "S0"
}

variable "sdb_firewall_ips"{
  type="map"
}