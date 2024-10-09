# Generate a random integer between 100000 and 999999 for the storage account suffix
resource "random_integer" "Storage_suffix" {
  min = 100000
  max = 999999
}

# Create a resource group for all departmental resources in the specified location
resource "azurerm_resource_group" "InvRG" {
  name = "${var.prefix}-Department"
  location = var.infra_location
}

############### Storage Account structure ########################

# Create a storage account with a name that includes the prefix of the department and the random suffix all in lowercase
resource "azurerm_storage_account" "Inventory-st" {
  name = "${lower(var.prefix)}st${random_integer.Storage_suffix.result}"
  resource_group_name = azurerm_resource_group.InvRG.name
  location = azurerm_resource_group.InvRG.location
  account_tier = "Standard"
  account_replication_type = "LRS"

#Tags the storage account with the department prefix
  tags = {
    environment = "${var.prefix}"
  }
  
}

#created inverntorie categories and it's sub-directories
resource "azurerm_storage_container" "Inventory-Categories" {
  name = "${lower(var.prefix)}-categories-folder"
  storage_account_name = azurerm_storage_account.Inventory-st.name
}

resource "azurerm_storage_blob" "Medical-Supplies" {
  name = "Medical-Supplies/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Categories.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Equipment" {
  name = "Equipment/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Categories.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Non-Medical-Supplies" {
  name = "Non-Medical-Supplies/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Categories.name
  type =  "Block"
}

resource "azurerm_storage_container" "Inventory-Suppliers" {
  name = "${lower(var.prefix)}-suppliers-folder"
  storage_account_name = azurerm_storage_account.Inventory-st.name
}

#Created sample supplier folder and it's sub-directories
resource "azurerm_storage_blob" "Supplier-A" {
  name = "Supplier-A/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-A-contracts" {
  name = "Supplier-A/Contracts/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-A-Invoices" {
  name = "Supplier-A/Invoices/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-A-Purchase-Orders" {
  name = "Supplier-A/Purchase-Orders/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-A-Receiving-Reports" {
  name = "Supplier-A/Receiving-Reports/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-A-Performance-Evaluations" {
  name = "Supplier-A/Performance-Evaluations/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-B" {
  name = "Supplier-B/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-B-contracts" {
  name = "Supplier-B/Contracts/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-B-Invoices" {
  name = "Supplier-B/Invoices/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-B-Purchase-Orders" {
  name = "Supplier-B/Purchase-Orders/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-B-Receiving-Reports" {
  name = "Supplier-B/Receiving-Reports/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Supplier-B-Performance-Evaluations" {
  name = "Supplier-B/Performance-Evaluations/"
  storage_account_name = azurerm_storage_account.Inventory-st.name
  storage_container_name = azurerm_storage_container.Inventory-Suppliers.name
  type =  "Block"
}


##################### Storage Account Structure End ##############

##################### Departmental Expenses tracking ##############

# Creates budget resource for monitoring departmental consumption

resource "azurerm_consumption_budget_resource_group" "Inventory-Budget" {
  name = "${var.prefix} Budget"
  resource_group_id = azurerm_resource_group.InvRG.id
  amount = 15
  time_grain = "Monthly"

  time_period {
    start_date = "2024-${var.budget_end_date}-01T00:00:00Z"
    end_date =   "2024-${var.budget_start_date}-01T00:00:00Z"
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
##################### Departmental Expenses tracking End ##############