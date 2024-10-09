# Generate a random integer between 100000 and 999999 for the storage account suffix
resource "random_integer" "Storage_suffix" {
  min = 100000
  max = 999999
}

# Create a resource group for all departmental resources in the specified location
resource "azurerm_resource_group" "FinanceRG" {
  name = "${var.prefix}-Department"
  location = var.infra_location
}

############### Storage Account structure ########################

# Create a storage account with a name that includes the prefix of the department and the random suffix all in lowercase
resource "azurerm_storage_account" "Finance-st" {
  name = "${lower(var.prefix)}st${random_integer.Storage_suffix.result}"
  resource_group_name = azurerm_resource_group.FinanceRG.name
  location = azurerm_resource_group.FinanceRG.location
  account_tier = "Standard"
  account_replication_type = "LRS"

#Tags the storage account with the department prefix
  tags = {
    environment = "${var.prefix}"
  }
  
}

#Creates folder for financial records and several folder/directories within it
resource "azurerm_storage_container" "finance-records-folder" {
  name = "${lower(var.prefix)}-records-folder"
  storage_account_name = azurerm_storage_account.Finance-st.name
}

resource "azurerm_storage_blob" "Revenue" {
  name = "Revenue/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-records-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Expenses" {
  name = "Expenses/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-records-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Budgets" {
  name = "Budgets/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-records-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Accounts-Payable" {
  name = "Accounts-Payable/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-records-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Accounts-Receivable" {
  name = "Accounts-Receivable/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-records-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Payroll" {
  name = "Payroll/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-records-folder.name
  type =  "Block"
}

#creates folder for the administrative documents and several other directories within
resource "azurerm_storage_container" "finance-administrative-folder" {
  name = "${lower(var.prefix)}-administrative-folder"
  storage_account_name = azurerm_storage_account.Finance-st.name
}

resource "azurerm_storage_blob" "Policies-and-Procedures" {
  name = "Policies-and-Procedures/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-administrative-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Legal-Documents" {
  name = "Legal-Documents/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-administrative-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Financial-Reports" {
  name = "Financial-Reports/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-administrative-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Audits" {
  name = "Audits/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-administrative-folder.name
  type =  "Block"
}

resource "azurerm_storage_blob" "Tax-Returns" {
  name = "Tax-Returns/"
  storage_account_name = azurerm_storage_account.Finance-st.name
  storage_container_name = azurerm_storage_container.finance-administrative-folder.name
  type =  "Block"
}


##################### Storage Account Structure End ##############

##################### Departmental Expenses tracking ##############

# Creates budget resource for monitoring departmental consumption

resource "azurerm_consumption_budget_resource_group" "Finance-Budget" {
  name = "${var.prefix} Budget"
  resource_group_id = azurerm_resource_group.FinanceRG.id
  amount = 15
  time_grain = "Monthly"
  time_period {
    start_date = "2024-${var.budget_start_date}-01T00:00:00Z"
    end_date =   "2024-${var.budget_end_date}-01T00:00:00Z"
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