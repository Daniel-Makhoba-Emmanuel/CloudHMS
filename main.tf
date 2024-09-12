######## Department Modules ##########



module "Finance" {
  source = "./Departments/Finance"
}

module "Hr" {
  source = "./Departments/Hr"
}

module "Inventory" {
  source = "./Departments/Inventory"
}

module "Global" {
  source = "./Departments/Global"
}