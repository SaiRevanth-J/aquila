resource "aws_security_group" "mysg-01" {
    name = "allow inbound rules "

    vpc_id = aws_vpc.Aquila-vpc.id

    ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "all traffic"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

   tags = {
    Name = "mysg-01"
  }
}

resource "aws_security_group" "app-sg" {
    name = "inbound rules "

    vpc_id = aws_vpc.Aquila-vpc.id

    ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.Aquila-vpc.cidr_block]
  }

    ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.Aquila-vpc.cidr_block]
  }

  ingress {
    description      = "db"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.Aquila-vpc.cidr_block]
  }
  ingress {
    description      = "custom"
    from_port        = 3010
    to_port          = 3010
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.Aquila-vpc.cidr_block]
  }
   ingress {
    description      = "custom"
    from_port        = 3011
    to_port          = 3011
    protocol         = "tcp"
    security_groups  = [aws_security_group.mysg-01.id]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

   tags = {
    Name = "app-sg"
  }
}

