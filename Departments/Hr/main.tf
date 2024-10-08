# Generate a random integer between 100000 and 999999 for the storage account suffix
resource "random_integer" "Storage_suffix" {
  min = 100000
  max = 999999
}

# Create a resource group for all departmental resources in the specified location
resource "azurerm_resource_group" "HR-RG" {
  name = "${var.prefix}-Department"
  location = var.infra_location
}

############### Storage Account structure ########################
# Create a storage account with a name that includes the prefix of the department and the random suffix all in lowercase
resource "azurerm_storage_account" "HR-st" {
  name = "${lower(var.prefix)}st${random_integer.Storage_suffix.result}"
  resource_group_name = azurerm_resource_group.HR-RG.name
  location = azurerm_resource_group.HR-RG.location
  account_tier = "Standard"
  account_replication_type = "LRS"

#Tags the storage account with the department prefix
  tags = {
    environment = "${var.prefix}"
  }
  
}

#Creates folder for HR's Employees and several folder/directories within it
resource "azurerm_storage_container" "HR-employee-folder" {
  name = "${lower(var.prefix)}-employees-folder"
  storage_account_name = azurerm_storage_account.HR-st.name
}

resource "azurerm_storage_blob" "Personnel-Information" {
  name = "Personnel-information/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-employee-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Employment-records" {
  name = "Employment-records/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-employee-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Benefits" {
  name = "Benefits/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-employee-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Time-and-attendance" {
  name = "Time-and-attendance/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-employee-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Training-and-Development" {
  name = "Training-and-Development/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-employee-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Exit-Documents" {
  name = "Exit-Documents/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-employee-folder.name
  type = "Block"
  
}

#creates folder for the administrative documents and several other directories within
resource "azurerm_storage_container" "HR-administrative-folder" {
  name = "${lower(var.prefix)}-administrative-folder"
  storage_account_name = azurerm_storage_account.HR-st.name
}

resource "azurerm_storage_blob" "Policies-and-Procedures" {
  name = "Policies-and-Procedures/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-administrative-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Legal-Documents" {
  name = "Legal-Documents/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-administrative-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Payroll-Records" {
  name = "Payroll-Records/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-administrative-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Recruitment-and-Selection" {
  name = "Recruitment-and-Selection/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-administrative-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Performance-Management" {
  name = "Performance-Management/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-administrative-folder.name
  type = "Block"
  
}

resource "azurerm_storage_blob" "Employee-Relations" {
  name = "Employee-Relations/"
  storage_account_name = azurerm_storage_account.HR-st.name
  storage_container_name = azurerm_storage_container.HR-administrative-folder.name
  type = "Block"
  
}

##################### Storage Account Structure End ##############

##################### Departmental Expenses tracking ##############

# Creates budget resource for monitoring departmental consumption
resource "azurerm_consumption_budget_resource_group" "HR-Budget" {
  name = "${var.prefix} Budget"
  resource_group_id = azurerm_resource_group.HR-RG.id
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