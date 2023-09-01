module "sap_iam_roles" {
  source = "./modules/iam"

  aws_region  = var.aws_region
  environment = var.environment

  s3_buckets_ec2_image_builder_logs = var.s3_buckets_ec2_image_builder_logs

  tags = local.tags
}

module "ec2_image_builder_RedHat" {
  source = "./modules/ec2-image-builder"

  aws_region = var.aws_region
  environment = var.environment
  app_name = "RHEL-${var.app_name}"
  kms_key_arn = var.kms_key_arn
  
  operating_system = "RHEL"
  base_ami = data.aws_ssm_parameter.ami_id_redhat.value
  s3_buckets_ec2_image_builder_logs = var.s3_buckets_ec2_image_builder_logs
  ec2_iam_role_name = module.sap_iam_roles.iam_instance_profile_name

  tags = local.tags
}

module "ec2_image_builder_OEL" {
  source = "./modules/ec2-image-builder"

  aws_region = var.aws_region
  environment = var.environment
  app_name = "OEL-${var.app_name}"
  kms_key_arn = var.kms_key_arn
  
  operating_system = "OEL"
  base_ami = data.aws_ssm_parameter.ami_id_oracle_linux.value
  s3_buckets_ec2_image_builder_logs = var.s3_buckets_ec2_image_builder_logs
  ec2_iam_role_name = module.sap_iam_roles.iam_instance_profile_name
  
  tags = local.tags
}