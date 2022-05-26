# //////////////////////////////////////
# VPC - Create the VPC
# //////////////////////////////////////
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.vpc_name}-vpc"
    }
  )
}

# //////////////////////////////////////
# VPC - Create subnets
# //////////////////////////////////////

# Create the public subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-${var.zones[count.index]}"
  }
}

# Create the private subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = var.zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc_name}-private-subnet-${var.zones[count.index]}"
  }
}

# Create the private subnets
resource "aws_subnet" "rds" {
  count = length(var.rds_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.rds_subnet_cidrs[count.index]
  availability_zone       = var.zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc_name}-rds-subnet-${var.zones[count.index]}"
  }
}
