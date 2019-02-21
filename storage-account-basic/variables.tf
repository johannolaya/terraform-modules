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

variable "containers" {
  default = []
  type = "list"
}

variable "queues" {
  default = []
  type = "list"
}

variable "tables" {
  default = []
  type = "list"
}

