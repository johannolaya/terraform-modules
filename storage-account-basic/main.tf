resource "random_id" "sa" {
  keepers = {
    azi_id = 1
  }
  byte_length = 8
}

resource "azurerm_storage_account" "sa" {
  name = "${random_id.sa.hex}"
  resource_group_name = "${var.rg_name}"
  location = "${var.location}"
  account_tier = "${var.sa_tier}"
  account_replication_type = "${var.sa_replication_type}"
}

resource "azurerm_storage_container" "sa_containers" {
  name = "${element(var.sa_containers,count.index%length(var.sa_containers))}"
  resource_group_name = "${var.rg_name}"
  storage_account_name = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
  count = "${length(var.sa_containers )}"
  depends_on = ["azurerm_storage_account.sa"]
}

resource "azurerm_storage_queue" "sa_queues" {
  name = "${element(var.sa_queues,count.index%length(var.sa_queues))}"
  resource_group_name = "${var.rg_name}"
  storage_account_name = "${azurerm_storage_account.sa.name}"
  count = "${length(var.sa_queues)}"
  depends_on = ["azurerm_storage_account.sa"]
}

resource "azurerm_storage_table" "sa_tables" {
  name = "${element(var.sa_tables,count.index%length(var.sa_tables))}"
  resource_group_name = "${var.rg_name}"
  storage_account_name = "${azurerm_storage_account.sa.name}"
  count = "${length(var.sa_tables)}"
  depends_on = ["azurerm_storage_account.sa"]
}