resource "aws_imagebuilder_infrastructure_configuration" "this" {
  description                   = "Infra config for when building a new AMI"
  instance_profile_name         = var.ec2_iam_role_name
  instance_types                = ["m4.2xlarge"]
  key_pair                      = data.aws_ssm_parameter.ssh_key_pair_name.value
  name                          = "${var.operating_system}-Infra-Config"
  terminate_instance_on_failure = true

  logging {
    s3_logs {
      s3_bucket_name = var.s3_bucket_ec2_image_builder_logs
      s3_key_prefix  = "ec2-image-builder-logs/Golden-Image-Builder-${var.operating_system}"
    }
  }

  resource_tags = var.tags
  tags = merge({
    "Name" = "${var.operating_system}-Infra"
    },
  var.tags)
}