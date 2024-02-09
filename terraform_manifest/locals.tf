locals {
  rgname       = "${var.rgname}"
  location     = "${var.location}"
  vnet_name    = "${var.vnet_name}"
  pip_name     = "${var.pip_name}"

  environment  = "dev"
  department   = "IT"
  mandate_tags = {
    env  = local.environment
    dept = local.department
  }
}
