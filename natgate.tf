resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = aws_subnet.public_web_01.id

  tags = {
    Name = "gw_NAT"
  }


}
