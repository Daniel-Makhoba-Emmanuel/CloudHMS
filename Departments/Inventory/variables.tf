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