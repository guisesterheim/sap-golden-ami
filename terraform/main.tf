module "s3_bucket_ec2_image_builder" {
  source = "./modules/s3"

  aws_region  = var.aws_region
  environment = var.environment

  kms_key_arn = data.aws_ssm_parameter.cmk_arn_s3.value
  bucket_name = "ec2-image-builder"

  tags = local.tags
}

module "sap_iam_roles" {
  source = "./modules/iam"

  aws_region  = var.aws_region
  environment = var.environment

  s3_bucket_ec2_image_builder_logs = module.s3_bucket_ec2_image_builder.bucket_name

  kms_keys_to_authorize = [
    data.aws_ssm_parameter.cmk_arn_s3.value,
    data.aws_ssm_parameter.cmk_arn_ec2_image_builder.value,
    data.aws_ssm_parameter.crm_arn_ebs.value
  ]

  tags = local.tags
}
