# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_subnet" "public_c" {
  availability_zone                              = var.availability_zones[1]
  cidr_block                                     = var.subnet_cidrs[1]
  map_public_ip_on_launch                        = true
  tags                                           = {}
  tags_all                                       = {}
  vpc_id                                         = aws_vpc.main.id
}

# __generated__ by Terraform
resource "aws_subnet" "public_a" {
  availability_zone                              = var.availability_zones[0]
  cidr_block                                     = var.subnet_cidrs[0]
  map_public_ip_on_launch                        = true
  tags                                           = {}
  tags_all                                       = {}
  vpc_id                                         = aws_vpc.main.id
}
