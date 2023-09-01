resource "aws_s3_object" "this" {
  for_each = fileset("/files/", "*")

  bucket = var.s3_buckets_ec2_image_builder_logs
  key    = "/files/${each.value}"
  source = "/files/${each.value}"
  # If the md5 hash is different it will re-upload
  etag = filemd5("/files/${each.value}")
}

resource "aws_imagebuilder_component" "custom_ansible" {
  name       = "RunAnsibleCustomScript"
  platform   = "Linux"
  uri        = "s3://${var.s3_buckets_ec2_image_builder_logs}/files/call_ansible.yaml"
  version    = "1.0.0"
  kms_key_id = var.kms_key_arn

  depends_on = [
    aws_s3_object.this
  ]
}