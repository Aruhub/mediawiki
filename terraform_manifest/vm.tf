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
        "sudo yum-config-manager --enable rhel-server-rhscl-7-rpms",
        "sudo yum install rh-php72",
        "scl enable rh-php72 bash",

        "sudo apt-get update && sudo apt-get install docker.io -y",
        "sudo mkdir /mnt/data && chmod 644 /mnt/data",
        "sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && sudo chmod 755 ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl",
        "curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/",
        "sudo minikube start --vm-driver=none",
        "sleep 30",
        "sudo apt-get install git -y",
        "sudo git clone https://github.com/Anurag-30/MediaWiki.git && cd MediaWiki && cd kubernetes && sudo kubectl create -f secrets.yaml -f persistent-volumes.yaml",
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
