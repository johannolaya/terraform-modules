resource "random_string" "kv" {
  length = 2
  special = false
  override_special = "/@\" "
}

resource "azurerm_key_vault" "kv" {
  name = "${var.location}-kv-${random_string.kv.result}-${var.channel_g}"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  sku {
    name = "${var.kv_sku}"
  }
  tenant_id = "${var.credential["tenant_id"]}"
  enabled_for_disk_encryption = true
}

/*resource "azurerm_key_vault_access_policy" "kv_policy" {
  count = "${length(var.policy_object)}"
  key_vault_id = "${azurerm_key_vault.kv.id}"
  tenant_id = "${var.credential["tenant_id"]}"
  object_id = "${element(var.policy_object,count.index%length(var.policy_object))}"
  key_permissions         = "${var.key_permissions}"
  secret_permissions      = "${var.secret_permissions}"
  certificate_permissions = "${var.certificate_permissions}"
}*/


resource "azurerm_key_vault_secret" "kv_secret" {
count = "${length(keys(var.secrets))}"
name = "${element(keys(var.secrets), count.index)}"
value     = "${element(values(var.secrets), count.index)}"
key_vault_id = "${azurerm_key_vault.kv.id}"
}

variable "jabs" {
  type = "list"
  default = [
    {
      object_id = "fa5ec449-053f-493c-a592-9a30cfca0e4c"
      key_permissions = ["get","list"]
      secret_permissions= ["list"]
      certificate_permissions= []
    },
    {
      object_id = "4e59aa54-2a5e-4a36-bfc2-2c986ce66116"
      key_permissions = ["get","list"]
      secret_permissions= ["list"]
      certificate_permissions= []
    }
  ]
}



resource "azurerm_key_vault_access_policy" "kv_policy" {
  count = "${length(var.jabs)}"
  key_vault_id = "${azurerm_key_vault.kv.id}"
  tenant_id = "${var.credential["tenant_id"]}"
  object_id = "${lookup(var.jabs[count.index], "object_id")}"
  key_permissions         = "${element(var.jabs[count.index], "key_permissions")}"
  secret_permissions         = "${element(var.jabs[count.index], "secret_permissions")}"
  certificate_permissions         = "${element(var.jabs[count.index], "certificate_permissions")}"
}