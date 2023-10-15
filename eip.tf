resource "aws_eip" "nat_gw" {

  depends_on                = [aws_internet_gateway.aquila_igw]
}
