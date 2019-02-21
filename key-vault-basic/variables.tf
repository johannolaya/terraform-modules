variable "rg_name" {
}

variable "location" {
}

variable "prefix_rs" {
}

variable "channel_g" {
}

variable "kv_sku" {
}

variable "credential" {
  type = "map"
}



variable "policy_object" {
  type = "list"
}

/*variable "microsoft_web_objectid" {
  default = ""
}*/


variable "key_permissions" {
   type = "list"

   default = [
     "get",
     "list",
   ]
 }

variable "secret_permissions" {
   type = "list"

   default = [
     "get",
     "list",
   ]
 }

variable "certificate_permissions" {
   type = "list"

   default = [
     "get",
     "list",
   ]
 }

variable "secrets" {
  default = {}
  type= "map"
}

