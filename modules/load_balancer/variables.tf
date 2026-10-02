variable "security_group_ids" {
    type = list(string)
}

variable "subnet_ids" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}

variable "worker_instance_id" {
    type = string
}