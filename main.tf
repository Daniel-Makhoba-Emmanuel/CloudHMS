
resource "random_integer" "sbns_suffix" {
  min = 100000
  max = 999999
}

######## Resource Groups ##########


resource "azurerm_resource_group" "GlobalRG" {
  name = "${var.CHMS_RG_name}-RG"
  location = var.infra_location
}

######## Azure Service Bus ##########
#did it break4

