data "aws_ssm_parameter" "ami_id_oracle_linux" {
  name = "/${var.environment}/amis/base/oel"
}

data "aws_ssm_parameter" "ami_id_redhat" {
  name = "/${var.environment}/amis/base/redhat"
}

data "aws_ssm_parameter" "cmk_arn_s3" {
  name = "/${var.environment}/kms/s3/arn"
}

data "aws_ssm_parameter" "cmk_arn_ec2_image_builder" {
  name = "/${var.environment}/kms/ec2-image-builder/arn"
}

data "aws_ssm_parameter" "crm_arn_ebs" {
  name = "/${var.environment}/kms/ebs/arn"
}

data "aws_ssm_parameter" "primary_subnet_id" {
  name = "/${var.environment}/vpc/subnets/private/primary/id"
}

data "aws_ssm_parameter" "secondary_subnet_id" {
  name = "/${var.environment}/vpc/subnets/private/secondary/id"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.environment}/vpc/id"
}
