variable "prefix" {
    type = string
    description = "applies prefix of department to all resources"
    default = "Finance"
}

variable "infra_location" {
    type = string
    description = "Location for the department infrastructure"
    default = "east us"
}