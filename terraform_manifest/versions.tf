terraform{
  required_version = ">= 1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azure"
      version = ">= 2.56.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "backend_rg"
    storage_account_name = "storage_name"
    container_name       = "tfstatefile"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
    features {}
}
