output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = tolist(aws_subnet.public[*].id)
}

output "private_subnet_ids" {
  value = tolist(aws_subnet.private[*].id)
}

output "rds_subnet_ids" {
  value = tolist(aws_subnet.rds[*].id)
}