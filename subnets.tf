resource "aws_subnet" "public_web_01" {
    vpc_id = aws_vpc.Aquila-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

      tags = {
    Name = "public_web_01"
  }
}

resource "aws_subnet" "public_web_02" {
    vpc_id = aws_vpc.Aquila-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"

      tags = {
    Name = "public_web_02"
  }
}

resource "aws_subnet" "private_app_01" {
    vpc_id = aws_vpc.Aquila-vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"

      tags = {
    Name = "private_app_01"
  }
}

resource "aws_subnet" "private_app_02" {
    vpc_id = aws_vpc.Aquila-vpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"

      tags = {
    Name = "private_app_02"
  }
}

resource "aws_subnet" "private_db_01" {
    vpc_id = aws_vpc.Aquila-vpc.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "us-east-1a"

      tags = {
    Name = "private_db_01"
  }
}
