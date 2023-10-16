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
}