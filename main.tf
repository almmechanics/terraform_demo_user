data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "sample" {
  name     = format("rg_sample_%s", var.id)
  location = var.location
  tags = {
    usage       = var.usage
    environment = var.environment
  }
}

module "external_template" {
  source = "github.com/almmechanics/terraform_module_demo?ref=20191215.34"

  location            = var.location
  id                  = var.id
  environment         = format("%03s%03d", var.environment, var.id)
  usage               = var.usage
  resource_group_name = azurerm_resource_group.sample.name
}