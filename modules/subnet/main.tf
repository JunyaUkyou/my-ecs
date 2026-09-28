resource "aws_subnet" "public_c" {
  availability_zone       = var.availability_zones_public_c
  cidr_block              = var.cidr_block_public_c
  map_public_ip_on_launch = true
  tags                    = {}
  tags_all                = {}
  vpc_id                  = var.vpc_id
}


resource "aws_subnet" "public_a" {
  availability_zone       = var.availability_zones_public_a
  cidr_block              = var.cidr_block_public_a
  map_public_ip_on_launch = true
  tags                    = {}
  tags_all                = {}
  vpc_id                  = var.vpc_id
}
