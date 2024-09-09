variable "prefix" {
    type = string
    description = "applies prefix of department to all resources"
    default = "HR"
}

variable "infra_location" {
    type = string
    description = "Location for department the infrastructure"
    default = "east us"
}