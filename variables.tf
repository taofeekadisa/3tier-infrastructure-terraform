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



variable "network_interface" {
  type = map(object({
    name = string
    #subnet_id               = string
    network_interface_ids = list(string)
  }))
  default = {
    "vm-nic1" = {
      name = "web-nic"
      #subnet_id               = var.sub_network["web-snet"]
      network_interface_ids = []
    }
    "vm-nic2" = {
      name = "api-nic"
      #subnet_id               = var.sub_network["api-snet"]
      network_interface_ids = []
    }
    "vm-nic3" = {
      name = "db-nic"
      #subnet_id               = var.sub_network["db-snet"]
      network_interface_ids = []
    }
  }
  description = "Network interface details"
}

variable "ip_config" {
  type        = string
  default     = "internal"
  description = "IP Configuration"
}


variable "azure_vm" {
  type = map(object({
    name     = string
    size     = string
    username = string
    password = string
    os_disk  = string
  }))
  default = {
    "vm1" = {
      name     = "web-vm"
      size     = "Standard_B1s"
      username = "adminuser"
      password = "Knixat@12345"
      os_disk  = "myosdisk1"
    }
    "vm2" = {
      name     = "api-vm"
      size     = "Standard_B1s"
      username = "adminuser"
      password = "Knixat@12345"
      os_disk  = "myosdisk2"
    }
    "vm3" = {
      name     = "db-vm"
      size     = "Standard_B1s"
      username = "adminuser"
      password = "Knixat@12345"
      os_disk  = "myosdisk3"
    }
  }
  description = "VM details"
}

