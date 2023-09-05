variable "environment" {
  description = "Environment being built. DEV, QA or PRD"
  type        = string
}

variable "aws_region" {
  description = "(Required) AWS Region to execute deployment to"
  type        = string
}

variable "app_name" {
  description = "Version to be used on EKS cluster"
  type        = string
}