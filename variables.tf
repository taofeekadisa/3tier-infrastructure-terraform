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
    "vnet" = "taofeek-vnet"
    "snet1" = "web-snet"
    "snet2" = "api-snet"
    snet3 = "db-snet"
  }
}

variable "address_prefixes" {
  type = map(string)
  default = {
    "vnet" = "10.0.0.0/16"
    "snet1" = "10.0.0.0/24"
    "snet2" = "10.0.1.0/24"
    "snet2" = "10.0.2.0/24"
  }
}