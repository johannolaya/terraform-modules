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

resource "azurerm_key_vault_access_policy" "default" {
  count = "${length(var.policy_object)}"
  vault_name          = "${azurerm_key_vault.kv.name}"
  resource_group_name = "${azurerm_key_vault.kv.resource_group_name}"

  tenant_id = "${var.credential["tenant_id"]}"
  object_id = "${lookup(var.policy_object[count.index],"object_id")}"

  key_permissions         = "${split(",",lookup(var.policy_object[count.index],"key_permissions"))}"
  secret_permissions      = "${split(",",lookup(var.policy_object[count.index],"secret_permissions"))}"
  certificate_permissions = "${split(",",lookup(var.policy_object[count.index],"certificate_permissions"))}"
}

  /*access_policy
  {
    count = "${length(var.access)}"
    tenant_id = "${var.credential["tenant_id"]}"
    object_id = "${var.credential["object_id"]}"
    key_permissions = "${var.kv_permissions}"
    secret_permissions = "${var.kv_secret_permissions}"
  }*/

/*access_policy {
  tenant_id = "${var.credential["tenant_id"]}"
  object_id = "${var.credential["object_id"]}"
  key_permissions = "${var.kv_permissions}"
  secret_permissions = "${var.kv_secret_permissions}"
}

access_policy {
  tenant_id = "${var.credential["tenant_id"]}"
  object_id = "${var.microsoft_web_objectid}"
  key_permissions = "${var.kv_permissions}"
  secret_permissions = "${var.kv_secret_permissions}"
}*/

resource "azurerm_key_vault_secret" "kv_secret" {
count = "${length(keys(var.secrets))}"
name = "${element(keys(var.secrets), count.index)}"
value     = "${element(values(var.secrets), count.index)}"
key_vault_id = "${azurerm_key_vault.kv.id}"
}
