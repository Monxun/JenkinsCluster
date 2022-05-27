provider "aws" {}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "terraform_remote_state" "jenkins_state" {
  backend = "s3"
  workspace = "jenkins"
  config = {
    bucket         = "jenkins-state-nightwalkers"
    key            = "us-east-1/s3/jenkins-terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "tf-state-jenkins-lock"
  }
}
data "aws_route53_zone" "selected" {
  name         = "smootheststack.com"
  private_zone = false
}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  region      = "us-west-1"
  name_prefix = "nightwalkers-serverless-jenkins"

  tags = {
    team     = "devops"
    solution = "jenkins"
  }
}

module "myip" {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

// Bring your own ACM cert for the Application Load Balancer
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"

  domain_name = "jenkins.${data.aws_route53_zone.selected.name}"
  zone_id     = data.aws_route53_zone.selected.zone_id

  tags = local.tags
}

// An example of creating a KMS key
resource "aws_kms_key" "efs_kms_key" {
  description = "KMS key used to encrypt Jenkins EFS volume"
}

module "serverless_jenkins" {
  source                        = "./modules/jenkins_platform"
  region                        = "us-west-1"
  name_prefix                   = "jenkins"
  tags                          = local.tags
  vpc_id                        = data.terraform_remote_state.jenkins_state.outputs.vpc_id
  efs_kms_key_arn               = aws_kms_key.efs_kms_key.arn
  efs_subnet_ids                = data.terraform_remote_state.jenkins_state.outputs.private_subnet_ids
  jenkins_controller_subnet_ids = data.terraform_remote_state.jenkins_state.outputs.private_subnet_ids
  alb_subnet_ids                = data.terraform_remote_state.jenkins_state.outputs.public_subnet_ids
  alb_ingress_allow_cidrs       = ["${module.myip.address}/32"]
  alb_acm_certificate_arn       = module.acm.this_acm_certificate_arn
  route53_create_alias          = true
  route53_alias_name            = "jenkins.${data.aws_route53_zone.selected.name}"
  route53_zone_id               = data.aws_route53_zone.selected.zone_id
}

