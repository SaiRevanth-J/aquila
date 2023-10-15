resource "aws_vpc" "Aquila-vpc" {
    
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    #main_route_table_id = aws_route_table.pubilc_route.id#
    
tags = {
    Name = "Aquila-vpc"
}
  
}
