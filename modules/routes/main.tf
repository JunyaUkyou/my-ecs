resource "aws_route_table" "public" {
  propagating_vgws = []
  tags     = {}
  tags_all = {}
  vpc_id   = var.vpc_id
}

#  Internet Gateway
resource "aws_internet_gateway" "main" {
  tags = {
    Name = var.internet_gateway_name
  }
  tags_all = {
    Name = var.internet_gateway_name
  }
  vpc_id = var.vpc_id
}

# Route
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.cidr_block
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = var.subnet_public_a_id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "public_c" {
  subnet_id      = var.subnet_public_c_id
  route_table_id = aws_route_table.public.id
}