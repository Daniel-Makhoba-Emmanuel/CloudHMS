variable "prefix" {
    type = string
    default = "Global"
    description = "This is the name for the RG for Global Resources(non-departmental)"
  
}

variable "infra_location" {
    type = string
    description = "Location for the infrastructure"
    default = "east us"
}