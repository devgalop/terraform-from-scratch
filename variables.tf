# This file contains the variables used in the Terraform configuration.

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "pseminario"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/24"
}

variable "subnet_1_cidr" {
  description = "The CIDR block for the first subnet"
  type        = string
  default     = "192.168.0.0/27"
}

variable "subnet_2_cidr" {
  description = "The CIDR block for the second subnet"
  type        = string
  default     = "192.168.0.32/27"
}

variable "subnet_3_cidr" {
  description = "The CIDR block for the third subnet"
  type        = string
  default     = "192.168.0.64/27"
}
  
variable "subnet_4_cidr" {
  description = "The CIDR block for the fourth subnet"
  type        = string
  default     = "192.168.0.96/27"
}

variable "subnet_5_cidr" {
  description = "The CIDR block for the fifth subnet"
  type        = string
  default     = "192.168.0.128/27"
}

variable "subnet_6_cidr" {
  description = "The CIDR block for the sixth subnet"
  type        = string
  default     = "192.168.0.160/27"
}

variable "subnet_7_cidr" {
  description = "The CIDR block for the seventh subnet"
  type        = string
  default     = "192.168.0.192/27"
}

variable "subnet_8_cidr" {
  description = "The CIDR block for the eighth subnet"
  type        = string
  default     = "192.168.0.224/27"
}

variable "availability_zone_1" {
  description = "The first availability zone to deploy resources in"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "The second availability zone to deploy resources in"
  type        = string
  default     = "us-east-1c"
}

variable "master_type" {
  description = "The instance type for the master node"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the instances"
  type        = string
  default     = "devgalop"
}

variable "root_volume_size" {
  description = "The size of the root volume for the instances"
  type        = number
  default     = 50
}

variable "root_volume_type" {
  description = "The type of the root volume for the instances"
  type        = string
  default     = "gp3"
}

