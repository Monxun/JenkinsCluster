#!/usr/bin/env bash

terraform init -lock=false

terraform destroy \
    -auto-approve=true \
    -lock=false 