resource "random_integer" "Storage_suffix" {
  min = 100000
  max = 999999
}
resource "azurerm_resource_group" "InvRG" {
  name = "${var.prefix}-Department"
  location = var.infra_location
}

resource "azurerm_storage_account" "Inventory-st" {
  name = "${lower(var.prefix)}st${random_integer.Storage_suffix.result}"
  resource_group_name = azurerm_resource_group.InvRG.name
  location = azurerm_resource_group.InvRG.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "${var.prefix}"
  }
  
}

resource "azurerm_consumption_budget_resource_group" "Inventory-Budget" {
  name = "${var.prefix} Budget"
  resource_group_id = azurerm_resource_group.InvRG.id
  amount = 15
  time_grain = "Monthly"
  time_period {
    start_date = "2024-10-01T00:00:00Z"
    end_date =   "2024-11-01T00:00:00Z"
  }
  notification {
    enabled = true
    threshold = 25.0
    operator = "EqualTo"

    contact_emails = [ "iamdanielemmanuelmark5@gmail.com" ]
  }

  notification {
    enabled = true
    threshold = 50.0
    operator = "EqualTo"

    contact_emails = [ "iamdanielemmanuelmark5@gmail.com" ]
  }
  
  notification {
    enabled = true
    threshold = 75.0
    operator = "EqualTo"

    contact_emails = [ "iamdanielemmanuelmark5@gmail.com" ]
  }
  
}
