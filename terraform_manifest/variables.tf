variable "rgname" {
  type = string
}

variable "location" {
    type = string
}

variable "vnet_name" {
    type = string
}

variable "dns_servers" {
  type = list(string)
}

variable "pip_name" {
  type = string
}

variable "subnet_details" {
  type = list(object({
    name = string
    address_prefix = string
  }))
  default = [
    {
      name           = "subnet1"
      address_prefix = "10.0.1.0/25"
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.1.128/25"
    }
  ]
}

variable "nsg_rule_details" {
    type = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
    default = [ {
      name                       = "port-ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    } ]
}

variable "computer_name" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
    type = string
}

variable "nic_name" {
  type = string
}
