resource "aws_internet_gateway" "aquila_igw" {
  vpc_id = aws_vpc.Aquila-vpc.id
  tags = {
    Name = "aquila_igw"
  }
}
