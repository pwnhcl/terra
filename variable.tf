variable "port" {
  type = list(string)
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "region" {
  type = string
}

variable "public_subnet_cidrs" {

  type = list(string)

  description = "Public Subnet CIDR values"

  default = ["192.168.100.0/24", "192.168.200.0/24",]

}



variable "private_subnet_cidrs" {

  type = list(string)

  description = "Private Subnet CIDR values"

  default = ["192.168.10.0/24", "192.168.20.0/24"]

}

variable "availabilityzone" {

  type = list(string)

  description = "Availability Zones"

  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

}