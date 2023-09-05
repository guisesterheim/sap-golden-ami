data "aws_ssm_parameter" "ami_id_oracle_linux" {
  name = "/${var.environment}/amis/oel"
}

data "aws_ssm_parameter" "ami_id_redhat" {
  name = "/${var.environment}/amis/redhat"
}

data "aws_ssm_parameter" "cmk_arn_s3" {
  name = "/${var.environment}/kms/s3/arn"
}

data "aws_ssm_parameter" "cmk_arn_ec2_image_builder" {
  name = "/${var.environment}/kms/ec2-image-builder/arn"
}