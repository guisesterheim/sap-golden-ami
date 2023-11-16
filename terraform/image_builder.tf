module "ec2_image_builder" {
  for_each = var.image_builder_map
  source   = "./modules/ec2-image-builder"

  aws_region  = var.aws_region
  environment = var.environment
  app_name    = "${each.value["app_name"]}-${var.app_name}"
  kms_key_arn = data.aws_ssm_parameter.cmk_arn_ec2_image_builder.value

  operating_system   = each.value["operating_system"]
  final_usage_of_ami = each.value["final_usage_of_ami"]
  target_account_ids = each.value["target_account_ids"]
  versions           = each.value["versions"]
  version_to_publish = each.value["version_to_publish"]

  base_ami                         = local.available_amis[each.value["base_ami"]]
  s3_bucket_ec2_image_builder_logs = module.s3_bucket_ec2_image_builder.bucket_name
  ec2_iam_role_name                = module.sap_iam_roles.iam_instance_profile_name

  subnet_id = data.aws_ssm_parameter.primary_subnet_id.value
  vpc_id    = data.aws_ssm_parameter.vpc_id.value

  tags = local.tags
}
