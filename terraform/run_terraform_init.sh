#!/bin/bash

ENVIRONMENT="predev"
BUCKET_NAME="pdev-bell-retail-aws-terraform-tfstate-files"
REGION="ca-central-1"

terraform \
            init \
            -backend-config "bucket=$BUCKET_NAME" \
            -backend-config "key=$ENVIRONMENT-retail-ec2-image-builder.tfstate" \
            -backend-config "region=$REGION" \
            -backend-config "skip_credentials_validation=true"
