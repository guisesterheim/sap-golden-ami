data "aws_caller_identity" "current" {}

data "aws_iam_policy" "permissions_boundary_policy" {
  arn = "arn:aws:iam::${data.aws_caller_identity.current.id}:policy/TenantPB"
}