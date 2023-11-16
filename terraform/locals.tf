locals {
  tags = {
    "ProjectID"  = "XXXXX"
    "CostCenter" = "itsre"
    "Product"    = var.app_name
    "Owner"      = "retail-IT"
    "EnvType"    = var.environment
    "ManagedBy"  = "Terraform"
    "GitHubRepo" = "https://gitlab.aws.dev/sesterhg/bell-retail-infra"
  }

  available_amis = {
    "rhel_8.8_sap" = data.aws_ssm_parameter.ami_id_redhat.value
    "oel_8.8_sap"  = data.aws_ssm_parameter.ami_id_oracle_linux.value
  }
}
