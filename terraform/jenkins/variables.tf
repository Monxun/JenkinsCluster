data "terraform_remote_state" "jenkins_state" {
  backend = "remote"

  config = {
    organization = "nightwalkers"
    workspaces = {
      name = "jenkins"
    }
  }
}

data "aws_route53_zone" "selected"{
  name = "smootheststack.com"
  private_zone = false
}



variable route53_domain_name {
  type        = string
  description = "The domain"
}

variable route53_zone_id {
  type        = string
  description = <<EOF
The route53 zone id where DNS entries will be created. Should be the zone id
for the domain in the var route53_domain_name.
EOF
}

variable jenkins_dns_alias {
  type        = string
  description = <<EOF
The DNS alias to be associated with the deployed jenkins instance. Alias will
be created in the given route53 zone
EOF
  default     = "jenkins-controller"
}

variable vpc_id {
  type        = string
  description = "The vpc id for where jenkins will be deployed"
  default = data.jenkins_state.vpc_id
}

variable efs_subnet_ids {
  type        = list(string)
  description = "A list of subnets to attach to the EFS mountpoint. Should be private"
  default = data.jenkins_state.private_subnet_ids
}

variable jenkins_controller_subnet_ids {
  type        = list(string)
  description = "A list of subnets for the jenkins controller fargate service. Should be private"
  default = data.jenkins_state.private_subnet_ids
}

variable alb_subnet_ids {
  type        = list(string)
  description = "A list of subnets for the Application Load Balancer"
  default = data.jenkins_state.public_subnet_ids
}