data "aws_ssm_parameter" "ssh_key_pair_name" {
  name = "/${var.environment}/ec2/ssh_key_pair/name"
}

data "aws_security_group" "default_group" {
  vpc_id = var.vpc_id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}
