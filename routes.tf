# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_route_table" "public" {
  propagating_vgws = []
  tags     = {}
  tags_all = {}
  vpc_id   = aws_vpc.main.id
}

#  Internet Gateway
resource "aws_internet_gateway" "main" {
  tags = {
    Name = var.internet_gateway_name
  }
  tags_all = {
    Name = var.internet_gateway_name
  }
  vpc_id = aws_vpc.main.id
}

# Route
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.cidr_block
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}