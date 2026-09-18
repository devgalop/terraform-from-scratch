# Aquí se definen las variables para el módulo de red (network)
# Es como un contrato que define qué variables espera el módulo y sus tipos.
# Si se manejan iteraciones, se deben crear variables para las listas de subnets y availability zones.
# Por ejemplo:
# variable "public_subnets" {
#   description = "The list of CIDR blocks for the public subnets"
#   type        = list(string)
# }
#
# variable "availability_zones" {
#   description = "The list of availability zones"
#   type        = list(string)
# }

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "availability_zone_1" {
  description = "The first availability zone"
  type        = string
}

variable "availability_zone_2" {
  description = "The second availability zone"
  type        = string
}


variable "public_subnet_1" {
  description = "The CIDR blocks for the public subnets"
  type        = string
}

variable "public_subnet_2" {
  description = "The CIDR block for the second public subnet"
  type        = string
}


variable "private_subnet_1" {
  description = "The CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_2" {
  description = "The CIDR block for the second private subnet"
  type        = string
}

variable "private_subnet_3" {
  description = "The CIDR block for the third private subnet"
  type        = string
}

variable "private_subnet_4" {
  description = "The CIDR block for the fourth private subnet"
  type        = string
}
