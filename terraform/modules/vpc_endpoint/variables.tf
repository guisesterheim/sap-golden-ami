variable "vpc_id" {
  description = "The VPC ID to place the builder instance in"
  type        = string
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs to place the VPC endpoint in"
  type        = list(string)
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}