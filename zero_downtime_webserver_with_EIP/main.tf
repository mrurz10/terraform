provider "aws" {
  region = "ap-south-1"    
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  tags = {
    Name = "EIP for webserver built by terraform"
    owner = "raheel"
  }
}


resource "aws_instance" "web" {
  ami = "ami-0fd05997b4dff7aac"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]  
  user_data = file("user_data.sh") 
  tags = {
    Name = "webserver build by terraform"
    owner = "raheel"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web" {
    name = "webserver"
    description = "security group for my webserver"
  ingress {
    description = "allow port http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  
  egress {
    description = "allow all ports"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
  tags = {
    Name = "webserver by terraform"
    owner = "raheel"
  }
}