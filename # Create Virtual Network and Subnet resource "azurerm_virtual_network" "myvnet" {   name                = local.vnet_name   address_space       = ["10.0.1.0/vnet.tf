# Create Virtual Network and Subnet
resource "azurerm_virtual_network" "myvnet" {
  name                = local.vnet_name
  address_space       = ["10.0.1.0/24"]
  resource_group_name = local.rgname
  location            = local.location
  dns_servers         = concat(var.dns_servers, ["1.2.3.4"]) #["10.0.1.4", "10.0.1.5"]
  
  dynamic "subnets" {
    for_each = var.subnet_details
    content{
        name             = subnets.value.name
        address_prefixes = subnets.value.address_prefixes
        security_group   = azurerm_network_security_group.nsg.id
    }    
  }
  depends_on = [azurerm_network_security_group.nsg]
  
  tags       = local.mandate_tags

  lifecycle {
    ignore_changes = [tags]
  }
}

# Create a Network Security
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = local.location
  resource_group_name = local.rgname
  dynamic "security_rule" {
    for_each = var.nsg_rule_details
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.name
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port
      destination_port_range     = security_rule.value.destination_port
      source_address_prefix      = security_rule.value.source_address
      destination_address_prefix = security_rule.value.destination_address
    }
  }
}

# Create Public IP Address
resource "azurerm_public_ip" "mypublicip" {
  name                = local.pip_name
  resource_group_name = local.rgname
  location            = local.location
  allocation_method   = "Static"
}
