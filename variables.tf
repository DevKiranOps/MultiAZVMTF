variable "MainRG" {
  default = "tfdemo"
  description = "The Name of the primary Resource Group"
}

variable "region" {
  default = "eastus"
  description = "Location of the primary Resource Group"
}

variable "webvmname" {
    description  = "Name for the web VM"
}

variable "webvmsize" {
    default = "Standard_B2s"
    description = "Size of the Web VM"
}

variable "admin_user" {
    description = "Username for VMs"
}


variable "password" {
    description = "Password for the VMs"
}

variable "vmcount" {
  description  = "Number of VMs to be created" 
}