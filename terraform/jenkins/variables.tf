

variable "jenkins_dns_alias" {
  type        = string
  description = <<EOF
The DNS alias to be associated with the deployed jenkins instance. Alias will
be created in the given route53 zone
EOF
  default     = "jenkins"
}

