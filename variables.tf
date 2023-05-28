variable "resource_group_name" {
  type        = string
  default     = "cohort3-taofeek-rg"
  description = "The Name which should be used for this Resource Group"
}

variable "location" {
  type        = string
  default     = "eastus2"
  description = "The Azure Region where the Resource Group should exist"
}

variable "tags" {
  type = map(string)
  default = {
    Owner        = "Taofeek Adisa"
    Environment  = "dev"
    Date_Created = "26/05/2023"
  }
}

variable "virtual_network" {
  type = map(string)
  default = {
    "vnet"    = "taofeek-vnet"
    "address" = "10.0.0.0/16"
  }
}

variable "sub_network" {
  type = map(string)
  default = {
    "web-snet" = "10.0.0.0/24"
    "api-snet" = "10.0.1.0/24"
    "db-snet"  = "10.0.2.0/24"
  }
}

variable "network_security_group" {
  type = map(string)
  default = {
    "web-snet" = "web-nsg"
    "api-snet" = "api-nsg"
    "db-snet"  = "db-nsg"
  }
}

variable "nsg-snet" {
  type = map(string)
  default = {
    "web-snet" = "web-nsg"
    "api-snet" = "api-nsg"
    "db-snet"  = "db-nsg"
  }
}


