variable "prefix_rs" {
}

variable "channel_g" {
}

variable "rg_name" {
}


variable "location" {
}

variable "sa_tier" {
}

variable "sa_replication_type" {
}

variable "sa_containers" {
  default = []
  type = "list"
}

variable "sa_queues" {
  default = []
  type = "list"
}

variable "sa_tables" {
  default = []
  type = "list"
}

