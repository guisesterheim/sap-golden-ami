#!/bin/bash

ENVIRONMENT="preDev"

terraform \
                destroy \
                -var-file $ENVIRONMENT.tfvars
