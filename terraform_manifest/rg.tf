# Create resource group

resource "azurerm_resource_group" "rg" {
    name     = local.rgname
    location = local.location
    tags     = local.mandate_tags
}
