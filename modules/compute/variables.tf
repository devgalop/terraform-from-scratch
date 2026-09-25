
variable "master_type" {
  description = "The instance type for the master instance"
  type        = string
}
variable "public_subnet_id" {
  description = "The ID of the public subnet where the master instance will be launched"
  type        = string
}
variable "security_group_id" {
  description = "The ID of the security group to associate with the master instance"
  type        = string
}
variable "key_name" {
  description = "The name of the key pair to use for SSH access to the master instance"
  type        = string
}
variable "root_volume_size" {
  description = "The size of the root volume for the master instance"
  type        = number
}
variable "root_volume_type" {
  description = "The type of the root volume for the master instance"
  type        = string
}