resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  tags                 = local.tags
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr_a
  availability_zone = var.zone_a
  tags              = local.tags

}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr_b
  availability_zone = var.zone_b
  tags              = local.tags
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "$(var.app_name)-$(var.env)-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  tags       = local.tags
}
