resource "azurerm_resource_group" "GlobalRG" {
  name = "${var.Dept_RG_name}-RG"
  location = var.infra_location
}