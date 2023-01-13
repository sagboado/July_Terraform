variable "region_name" {
    description = "name of region"
    default = "eu-west-2"
    type = string
  
}

variable "cidr_for_vpc" {
    description = "the cidr for VPC"
    default = "10.0.0.0/16"
    type = string
  
}

variable "cidr_for_public_sub_1" {
    description = "public cidr"
    default = "10.0.1.0/24"
    type = string
  
}

variable "cidr_for_public_sub_2" {
    description = "public cidr"
    default = "10.0.2.0/24"
    type = string
  
}

variable "cidr_for_private_sub_1" {
    description = "private cidr"
    default = "10.0.3.0/24"
    type = string
  
}

variable "cidr_for_private_sub_2" {
    description = "private cidr"
    default = "10.0.4.0/24"
    type = string
  
}

variable "AZ_1" {
    description = "availability zone"
    default = "eu-west-2a"
    type = string
  
}

variable "AZ_2" {
    description = "availability zone"
    default = "eu-west-2b"
    type = string
  
}

variable "AZ_3" {
    description = "availability zone"
    default = "eu-west-2c"
    type = string
  
}