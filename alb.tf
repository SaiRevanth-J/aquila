module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "aquila-app"

  load_balancer_type = "application"

  vpc_id             = aws_vpc.Aquila-vpc.id
  subnets            = [aws_subnet.public_web_01.id,aws_subnet.public_web_02.id ]
  security_groups    = [aws_security_group.mysg-01.id,aws_security_group.app-sg.id]

  target_groups = [
    {
      name_prefix      = "app"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = aws_instance.app-server.id
          port = 3010
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}
