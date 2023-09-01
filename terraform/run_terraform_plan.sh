#!/bin/bash

ENVIRONMENT="preDev"

terraform \
                plan \
                -var-file $ENVIRONMENT.tfvars \
                -out tfplan.log
