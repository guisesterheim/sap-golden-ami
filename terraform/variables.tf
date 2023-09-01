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

variable "kms_key_arn" {
  description = "Key ARN on KMS to use"
  type        = string
}

variable "s3_buckets_ec2_image_builder_logs" {
  description = "S3 buckets to allow access into"
  type        = string
}