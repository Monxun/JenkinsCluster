#!/usr/bin/env bash

export DEPLOYMENT_NAME=${PWD##*/}  

rm -rf .terraform

terraform init

terraform plan \
    -lock=false \
    -input=false \
    -out=tf-$DEPLOYMENT_NAME.plan

terraform apply \
    -input=false \
    -auto-approve=true \
    -lock=false \
    tf-$DEPLOYMENT_NAME.plan