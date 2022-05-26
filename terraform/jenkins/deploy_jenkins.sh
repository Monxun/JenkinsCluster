#!/usr/bin/env bash
set -e

source vars.sh

# Start from a clean slate
rm -rf .terraform

terraform init

terraform plan \
    -lock=false \
    -input=false \
    -out=tf.plan

terraform apply \
    -input=false \
    -auto-approve=true \
    -lock=true \
    tf.plan