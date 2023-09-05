resource "aws_s3_object" "this" {
  for_each = fileset(path.module, "files/*")

  bucket = var.s3_bucket_ec2_image_builder_logs
  key    = "/ec2-image-builder/components/${var.operating_system}/${each.value}"
  source = "${path.module}/${each.value}"
  # If the md5 hash is different it will re-upload
  etag = filemd5("${path.module}/${each.value}")
}

resource "aws_imagebuilder_component" "custom_ansible" {
  name       = "${var.operating_system}-RunAnsibleForGoldenAMI"
  platform   = "Linux"
  supported_os_versions = ["Red Hat Enterprise Linux 7", "Oracle Enterprise Linux 8"]
  uri        = "s3://${var.s3_bucket_ec2_image_builder_logs}/ec2-image-builder/components/${var.operating_system}/files/call_ansible.yaml"
  version    = "1.0.0"
  kms_key_id = var.kms_key_arn

  depends_on = [
    aws_s3_object.this
  ]

  lifecycle {
    replace_triggered_by = [
      aws_s3_object.this
    ]
  }

  tags = merge({
    "Name" = "${var.operating_system}-Infra"
    },
  var.tags)
}