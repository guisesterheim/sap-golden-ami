# TODO: remove this resource below called "aws_s3_object.this" this was created for when we don't have access to Gitlab. Once we have it, delete this resource
resource "aws_s3_object" "ansible_zip_file" {
  bucket = var.s3_bucket_ec2_image_builder_logs
  key    = "/ec2-image-builder/components/${var.operating_system}/files/ansible.zip"
  source = "${path.module}/files/ansible.zip"

  # If the md5 hash is different it will re-upload
  source_hash = filemd5("${path.module}/files/ansible.zip")
}

resource "aws_imagebuilder_infrastructure_configuration" "this" {
  description                   = "Infra config for when building a new AMI"
  instance_profile_name         = var.ec2_iam_role_name
  instance_types                = ["m4.2xlarge"]
  key_pair                      = data.aws_ssm_parameter.ssh_key_pair_name.value
  name                          = "itsre-${var.environment}-${var.operating_system}-Infra-Config"
  terminate_instance_on_failure = true
  subnet_id                     = var.subnet_id
  security_group_ids            = [data.aws_security_group.default_group.id]

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