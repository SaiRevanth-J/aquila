data "aws_ami" "ec2_latest" {
most_recent      = true
 owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }
  
}

data "aws_ami" "ubuntu_latest" {
most_recent      = true
 owners = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]

  }
  
}
resource "aws_instance" "loginserver" {
    ami= data.aws_ami.ubuntu_latest.id
    instance_type= "t2.micro"
    associate_public_ip_address = true
    
    subnet_id = aws_subnet.public_web_01.id
    key_name = "newkey1234"
    vpc_security_group_ids = [aws_security_group.mysg-01.id]


    user_data = file("key.sh")
    root_block_device {
      volume_size = 8
      volume_type = "gp2"
    }
   

  tags = {
    Name = "loginserver"
  }  
 
}

 resource "aws_instance" "app-server" {
    ami= data.aws_ami.ubuntu_latest.id
    instance_type= "t2.medium"
    subnet_id = aws_subnet.private_app_01.id
    key_name = "newkey1234"
    vpc_security_group_ids = [aws_security_group.app-sg.id]

    root_block_device {
      volume_size = 8
      volume_type = "gp2"
    }
connection {
    bastion_host = aws_instance.loginserver.public_ip
    bastion_user = "ubuntu"
    bastion_host_key = file("./newkey1234.pem")
    host     = self.private_ip
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./newkey1234.pem")
   
  }

provisioner "remote-exec" {
    inline = [
"sudo apt update -y",
"sudo wget https://nodejs.org/dist/v18.18.2/node-v18.18.2-linux-x64.tar.xz",
"sudo tar -xvf node-v18.18.2-linux-x64.tar.xz",
"sudo echo 'PATH=$PATH:/home/ubuntu/node-v18.18.2-linux-x64/bin' >> ~/.bashrc",
"sleep 5",
"source  ~/.bashrc",
"npm install --global yarn",
"sudo apt install -y g++ gcc libgcc libstdc++ linux-headers make python libtool automake autoconf nasm wkhtmltopdf vips vips-dev libjpeg-turbo libjpeg-turbo-dev -y",
"sudo wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb",
"sudo dpkg -i wkhtmltox_0.12.6.1-2.jammy_amd64.deb",
"sudo apt --fix-broken install -y ",
"sudo apt install -y git",
"git clone https://github.com/AquilaCMS/AquilaCMS.git",

    ]

  }
     
                 
  tags = {
    Name = "app-server"
  }  

}

resource "aws_instance" "db-server" {
    ami= data.aws_ami.ubuntu_latest.id
    instance_type= "t2.micro"
    subnet_id = aws_subnet.private_db_01.id
    key_name = "newkey1234"
    vpc_security_group_ids = [aws_security_group.app-sg.id]

    root_block_device {
      volume_size = 8
      volume_type = "gp2"
    }
    user_data = <<EOF
#!/bin/bash
sudo wget https://downloads.mongodb.com/compass/mongodb-mongosh_2.0.1_amd64.deb
sudo dpkg -i mongodb-mongosh_2.0.1_amd64.deb
sudo wget https://repo.mongodb.org/apt/ubuntu/dists/jammy/mongodb-org/7.0/multiverse/binary-amd64/mongodb-org-server_7.0.2_amd64.deb
sudo dpkg -i mongodb-org-server_7.0.2_amd64.deb
sudo systemctl start mongod.service
sudo systemctl enable  mongod.service

EOF
                  
  tags = {
    Name = "db-server"
  }  

}


