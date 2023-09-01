data "aws_ssm_parameter" "ami_id_oracle_linux" {
  name = "/${var.environment}/amis/oel"
}

data "aws_ssm_parameter" "ami_id_redhat" {
  name = "/${var.environment}/amis/redhat"
}