resource "random_integer" "redis_suffix" {
  min = 100000
  max = 999999
}
resource "azurerm_resource_group" "GlobalRG" {
  name = "${var.prefix}-RG"
  location = var.infra_location
}

resource "azurerm_redis_cache" "Global-redis" {
  name = "${lower(var.prefix)}-redis${random_integer.redis_suffix.result}"
  resource_group_name = azurerm_resource_group.GlobalRG.name
  location = azurerm_resource_group.GlobalRG.location
  capacity = 0
  sku_name = "Basic"
  family = "C"
}