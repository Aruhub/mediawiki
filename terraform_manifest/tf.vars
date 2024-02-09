
rgname = "test-rg"
location = "eastus2"
vnet_name = "test-vnet"
dns_servers = ["10.0.1.5"]
pip_name = "test-public-ip"
subnet_details =[
    { name = "subnet1", address_prefix = "10.0.1.0/25"},
    { name = "subnet2", address_prefix = "10.0.1.128/25"}
]
nsg_rule_details= [
    {
      name                       = "port-ssh",
      priority                   = 100,
      direction                  = "Inbound",
      access                     = "Allow",
      protocol                   = "Tcp",
      source_port_range          = "*",
      destination_port_range     = "22",
      source_address_prefix      = "*",
      destination_address_prefix = "*",
    },
    {
      name                       = "port-http",
      priority                   = 101,
      direction                  = "Inbound",
      access                     = "Allow",
      protocol                   = "Tcp",
      source_port_range          = "*",
      destination_port_range     = "80",
      source_address_prefix      = "*",
      destination_address_prefix = "*"
    }
]
computer_name = "test-vm01"
admin_username = "adminuser123"
admin_password = "password@123"



