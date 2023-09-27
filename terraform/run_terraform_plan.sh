#!/bin/bash

ENVIRONMENT="predev"

terraform \
                plan \
                -var-file $ENVIRONMENT.tfvars \
                -out tfplan.log
