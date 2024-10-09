variable "prefix" {
    type = string
    description = "applies prefix of department to all resources"
    default = "Inventory"
}

variable "infra_location" {
    type = string
    description = "Location for department the infrastructure"
    default = "east us"
}

variable "budget_start_date" {
  type = string
  description = "start date of the budget for the department"
  default = "10"
}

variable "budget_end_date" {
  type = string
  description = "end date of the budget for the department"
  default = "11"
}