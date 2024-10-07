resource "random_integer" "Storage_suffix" {
  min = 100000
  max = 999999
}

resource "azurerm_resource_group" "FinanceRG" {
  name = "${var.prefix}-Department"
  location = var.infra_location
}

############### Storage Account structure ########################

resource "azurerm_storage_account" "Finance-st" {
  name = "${lower(var.prefix)}st${random_integer.Storage_suffix.result}"
  resource_group_name = azurerm_resource_group.FinanceRG.name
  location = azurerm_resource_group.FinanceRG.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "${var.prefix}"
  }
  
}

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


resource "azurerm_consumption_budget_resource_group" "Finance-Budget" {
  name = "${var.prefix} Budget"
  resource_group_id = azurerm_resource_group.FinanceRG.id
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
