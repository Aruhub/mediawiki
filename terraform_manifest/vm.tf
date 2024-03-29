# Get Subnet details
data "azurerm_subnet" "vmsubnet" {
  name                 = var.subnet_details[0].name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rgname
}

# Get Public IP details
data "azurerm_public_ip" "pip" {
  name                = local.pip_name
  resource_group_name = local.rgname
}

# Create Network Interface
resource "azurerm_network_interface" "myvmnic" {
  name                = concat(var.vm_name, "-nic01")
  location            = local.location
  resource_group_name = local.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.vmsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublicip.id 
  }
}


# Create a Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  name                  = var.vm_name  
  resource_group_name   = local.rgname
  location              = local.location
  size                  = var.vmsize
  network_interface_ids = [ azurerm_network_interface.myvmnic.id ]

  os_disk {
    name = "osdisk"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  computer_name                   = var.computer_name  # Hostname of the VM
  admin_username                  = var.admin_username 
  admin_password                  = var.admin_password 
  disable_password_authentication = false

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

  provisioner "remote-exec" {
    inline = [
        "sleep 120",
        "sudo apt-get update",
        "sleep 60",
        "sudo mkdir /mnt/media/ && chmod 744 /mnt/media",
        
        "sleep 120",
        "sudo curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl && sudo chmod 755 ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl",
        "sudo apt install git-all"
        "sudo git clone https://github.com/Arubhub/mediaWiki.git && cd mediaWiki && cd kube_manifests && sudo kubectl create -f secrets.yaml -f persistent-volumes.yaml",
       
        "sudo kubectl create  -f mariadb-deployment.yaml -f mariadb-svc.yaml",
        "sudo kubectl create -f app-deployment.yaml -f web-service.yaml"
        ]
    connection {
      host     = data.azurerm_public_ip.pip.id
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
    }      
  }
}
