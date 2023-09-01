data "aws_ssm_parameter" "ssh_key_pair_name" {
  name = "/${var.environment}/ec2/ssh_key_pair_name"
}

