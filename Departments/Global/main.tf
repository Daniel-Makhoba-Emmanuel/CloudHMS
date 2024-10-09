# Generate a random integer between 100000 and 999999 for the storage account suffix

resource "random_integer" "redis_suffix" {
  min = 100000
  max = 999999
}

# Create a resource group for global  resources in the specified location

resource "azurerm_resource_group" "GlobalRG" {
  name = "${var.prefix}-RG"
  location = var.infra_location
}

#creates azure redis cashe for circuit breaker Logic
resource "azurerm_redis_cache" "Global-redis" {
  name = "${lower(var.prefix)}-redis${random_integer.redis_suffix.result}"
  resource_group_name = azurerm_resource_group.GlobalRG.name
  location = azurerm_resource_group.GlobalRG.location
  capacity = 0
  sku_name = "Basic"
  family = "C"
}

#creates the global virtual network for filtering and directing traffic and its subnet's
resource "azurerm_virtual_network" "Global-vnet" {
  name = "${var.prefix}-vnet"
  location = azurerm_resource_group.GlobalRG.location
  resource_group_name = azurerm_resource_group.GlobalRG.name
  address_space = [ "10.0.0.0/24" ]
}

resource "azurerm_subnet" "Globalsubnet1" {
  name = "${var.prefix}-subnet1"
  resource_group_name = azurerm_resource_group.GlobalRG.name
  virtual_network_name = azurerm_virtual_network.Global-vnet.name
  address_prefixes = [ "10.0.0.0/26" ]
  
}

resource "azurerm_subnet" "Globalsubnet2" {
  name = "${var.prefix}-subnet2"
  resource_group_name = azurerm_resource_group.GlobalRG.name
  virtual_network_name = azurerm_virtual_network.Global-vnet.name
  address_prefixes = [ "10.0.0.64/26" ]
  
}

resource "azurerm_subnet" "Globalsubnet3" {
  name = "${var.prefix}-subnet3"
  resource_group_name = azurerm_resource_group.GlobalRG.name
  virtual_network_name = azurerm_virtual_network.Global-vnet.name
  address_prefixes = [ "10.0.0.128/26" ]
  
}

resource "azurerm_subnet" "Globalsubnet4" {
  name = "${var.prefix}-subnet4"
  resource_group_name = azurerm_resource_group.GlobalRG.name
  virtual_network_name = azurerm_virtual_network.Global-vnet.name
  address_prefixes = [ "10.0.0.192/26" ]
  
}