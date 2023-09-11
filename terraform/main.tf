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

  kms_keys_to_authorize = [data.aws_ssm_parameter.cmk_arn_s3.value, data.aws_ssm_parameter.cmk_arn_ec2_image_builder.value]

  tags = local.tags
}

module "ec2_image_builder_RedHat" {
  source = "./modules/ec2-image-builder"

  aws_region = var.aws_region
  environment = var.environment
  app_name = "RHEL-${var.app_name}"
  kms_key_arn = data.aws_ssm_parameter.cmk_arn_ec2_image_builder.value
  
  operating_system = "RHEL"
  final_usage_of_ami = "SAP"
  base_ami = data.aws_ssm_parameter.ami_id_redhat.value
  s3_bucket_ec2_image_builder_logs = module.s3_bucket_ec2_image_builder.bucket_name
  ec2_iam_role_name = module.sap_iam_roles.iam_instance_profile_name

  tags = local.tags
}

module "ec2_image_builder_OEL" {
  source = "./modules/ec2-image-builder"

  aws_region = var.aws_region
  environment = var.environment
  app_name = "OEL-${var.app_name}"
  kms_key_arn = data.aws_ssm_parameter.cmk_arn_ec2_image_builder.value
  
  operating_system = "OEL"
  final_usage_of_ami = "SAP-and-Oracle"
  base_ami = data.aws_ssm_parameter.ami_id_oracle_linux.value
  s3_bucket_ec2_image_builder_logs = module.s3_bucket_ec2_image_builder.bucket_name
  ec2_iam_role_name = module.sap_iam_roles.iam_instance_profile_name
  
  tags = local.tags
}