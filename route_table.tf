resource "aws_route_table" "pubilc_route" {
  vpc_id = aws_vpc.Aquila-vpc.id

  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.aquila_igw.id

  }
tags = {
  "Name" = "public_rt"
}
}

resource "aws_route_table_association" "pubilc_a" {
  subnet_id      = aws_subnet.public_web_01.id
  route_table_id = aws_route_table.pubilc_route.id
}

resource "aws_route_table_association" "pubilc_b" {
  subnet_id      = aws_subnet.public_web_02.id
  route_table_id = aws_route_table.pubilc_route.id
}
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.Aquila-vpc.id

route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_nat_gateway.nat.id

  }
 
tags = {
  "Name" = "private_rt"
}
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_app_01.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_app_02.id
  route_table_id = aws_route_table.private_route.id
}
resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_db_01.id
  route_table_id = aws_route_table.private_route.id
}
