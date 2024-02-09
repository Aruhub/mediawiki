# Output Resource Group
output "resource_group_id" {
  value = azurerm_resource_group.rg.id 
}
output "resource_group_name" {
  value = azurerm_resource_group.rg.name  
}

# Output Virtual Network
output "virtual_network_name" {
  value = azurerm_virtual_network.myvnet.name 
}

# Output Virtual Machine
output "vm_public_ip_address" {
  value = azurerm_linux_virtual_machine.mylinuxvm.public_ip_address
}

# Output Virtual Machine Admin User & Password
output "vm_admin_user" {  
  value = azurerm_linux_virtual_machine.mylinuxvm.admin_username
}

output "vm_admin_pwd" {
    value = azurerm_linux_virtual_machine.mylinuxvm.admin_password
    sensitive = true
  
}


