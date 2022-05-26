# //////////////////////////////////////
# PRIVATE NACLS
# /////////////////////////////////////
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.public[0].id, aws_subnet.public[1].id]

  # Ingress rules
  # Allow all local traffic
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_vpc.this.cidr_block
    from_port  = 0
    to_port    = 0
  }

  # Allow HTTPS traffic from the internet
  ingress {
    protocol   = "6"
    rule_no    = 105
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Allow HTTP traffic from the internet
  ingress {
    protocol   = "6"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Allow the ephemeral ports from the internet
  ingress {
    protocol   = "6"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65534
  }

  ingress {
    protocol   = "17"
    rule_no    = 125
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65534
  }

  # Egress rules
  # Allow all ports, protocols, and IPs outbound
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.vpc_name}-public-nacl"
  }

  depends_on = [aws_subnet.public]
}


# //////////////////////////////////////
# PRIVATE NACLS
# /////////////////////////////////////
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.private[0].id, aws_subnet.private[1].id]

  # Ingress rules
  # Allow all local traffic
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_vpc.this.cidr_block
    from_port  = 0
    to_port    = 0
  }

  # Allow HTTP web traffic from anywhere
  ingress {
    protocol   = 6
    rule_no    = 105
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Allow HTTPS web traffic from anywhere
  ingress {
    protocol   = 6
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Allow the ephemeral ports from the internet
  ingress {
    protocol   = "6"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65534
  }

  ingress {
    protocol   = "17"
    rule_no    = 125
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65534
  }

  # Egress rules
  # Allow all ports, protocols, and IPs outbound
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.vpc_name}-private-nacl"
  }
}