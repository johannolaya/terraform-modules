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
  name = "${element(var.containers,count.index%length(var.containers))}"
  resource_group_name = "${var.rg_name}"
  storage_account_name = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
  count = "${length(var.containers )}"
  depends_on = ["azurerm_storage_account.sa"]
}

resource "azurerm_storage_queue" "sa_queues" {
  name = "${element(var.queues,count.index%length(var.queues))}"
  resource_group_name = "${var.rg_name}"
  storage_account_name = "${azurerm_storage_account.sa.name}"
  count = "${length(var.queues)}"
  depends_on = ["azurerm_storage_account.sa"]
}

resource "azurerm_storage_table" "sa_tables" {
  name = "${element(var.tables,count.index%length(var.tables))}"
  resource_group_name = "${var.rg_name}"
  storage_account_name = "${azurerm_storage_account.sa.name}"
  count = "${length(var.tables)}"
  depends_on = ["azurerm_storage_account.sa"]
}