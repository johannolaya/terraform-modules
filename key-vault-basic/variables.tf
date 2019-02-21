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
     "backup",
     "create",
     "decrypt",
     "delete",
     "encrypt",
     "get",
     "import",
     "list",
     "purge",
     "recover",
     "restore",
     "sign",
     "unwrapKey",
     "update",
     "verify",
     "wrapKey"
   ]
 }

variable "secret_permissions" {
   type = "list"

   default = [
     "backup",
     "delete",
     "get",
     "list",
     "purge",
     "recover",
     "restore",
     "set"
   ]
 }

variable "certificate_permissions" {
   type = "list"

   default = ["list"]
 }

variable "secrets" {
  default = {}
  type= "map"
}

