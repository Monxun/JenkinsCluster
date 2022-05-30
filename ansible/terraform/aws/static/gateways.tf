# //////////////////////////////////////
# IGW - Gateway
# //////////////////////////////////////

# Add internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name      = "${var.vpc_name}-internet-gateway"
    workspace = var.workspace_name
  }
}

# Charges may occur

# Reserve EIPs
resource "aws_eip" "nat_a" {
  vpc = true

  tags = {
    Name      = "${var.vpc_name}-eip-nat-a"
    workspace = var.workspace_name
  }
}

# //////////////////////////////////////
# NAT - Gateways
# //////////////////////////////////////
# NAT Gateway in AZ A
resource "aws_nat_gateway" "zone_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name      = "${var.vpc_name}-nat-gateway-aza"
    workspace = var.workspace_name
  }

  depends_on = [
    aws_subnet.public
  ]
}

# Reserve EIPs
resource "aws_eip" "nat_b" {
  vpc = true

  tags = {
    Name      = "${var.vpc_name}-eip-nat-b"
    workspace = var.workspace_name
  }
}

# NAT Gateway in AZ B
resource "aws_nat_gateway" "zone_b" {
  allocation_id = aws_eip.nat_b.id
  subnet_id     = aws_subnet.public[1].id

  tags = {
    Name      = "${var.vpc_name}-nat-gateway-azb"
    workspace = var.workspace_name
  }

  depends_on = [
    aws_subnet.public
  ]
}