# vars.tf


# //////////////////////////////////////
# AWS - Variables
# /////////////////////////////////////
variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "zones" {
  type    = list
  default = ["us-west-1b", "us-west-1c"]
}


# //////////////////////////////////////
# VPC - Variables
# /////////////////////////////////////
variable "vpc_name" {
  type    = string
  default = "nightwalkers-vpc"
}

variable "additional_tags" {
  type = map(string)
  default = {
    owner = "nightwalkers"
    managed_by = "terraform"
  }
}

variable "vpc_cidr" {
  type    = string
  default = "10.44.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list
  default = ["10.44.10.0/24", "10.44.11.0/24"]
}

variable "private_subnet_cidrs" {
  type = list
  default = ["10.44.20.0/24", "10.44.21.0/24"]
}

variable "rds_subnet_cidrs" {
  type = list
  default = ["10.44.30.0/24", "10.44.31.0/24"]
}


# //////////////////////////////////////
# SECURITY GROUPS - Variables
# /////////////////////////////////////
variable "default_security_group_ingress" {
  description = "List of maps of ingress rules to set on the default security group"
  type        = list(map(string))
  default = [
    {
      cidr_blocks = "10.44.0.0/16"
      description = "Allow all from the local network."
      from_port   = 0
      protocol    = "-1"
      self        = false
      to_port     = 0
    },
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all HTTPS from the internet."
      from_port   = 443
      protocol    = "6"
      self        = false
      to_port     = 443
    },
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all HTTP from the internet."
      from_port   = 80
      protocol    = "6"
      self        = false
      to_port     = 80
    },
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all ephemeral ports from the internet."
      from_port   = 32768
      protocol    = "6"
      self        = false
      to_port     = 60999
    }
  ]
}

variable "default_security_group_egress" {
  description = "List of maps of egress rules to set on the default security group"
  type        = list(map(string))
  default = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all"
      from_port   = 0
      protocol    = "-1"
      self        = false
      to_port     = 0
    }
  ]
}