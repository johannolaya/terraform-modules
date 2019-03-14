variable "rg_name" {
}

variable "location" {
}

variable "prefix_rs" {
}

variable "channel_g" {
}

variable "sp_tier" {
}

variable "sp_size" {
}

variable "app_settings" {
  type = "map"
}

variable "app_settings_slot" {
  type = "map"
}

variable "app_tls_version" {
}

variable "app_insights_name" {
  default="automationManagerAppInsightsInstrumentationKey"
}

variable "app_insights_name_02" {
  default="automationManagerAppInsightsInstrumentationKey"
}

variable "app_insights_location" {
  default="eastus"
}

variable "app_default_documents" {
  type="list"
  default=[]
}

variable "connection_01" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_02" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_03" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_04" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_05" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_06" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}



variable "connection_slot_01" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_slot_02" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_slot_03" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_slot_04" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_slot_05" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}

variable "connection_slot_06" {
  default = {
    name = "DefaultDatabase"
    type = "SQLServer"
    value = "no reference"
  }
  type= "map"
}
