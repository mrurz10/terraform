provider "aws" {
    region = "ap-south-1"
    alias = "MUMBAI"
}

provider "aws" {
    region = "us-east-1"
    alias = "VIRGINIA"
}

provider "aws" {
    region = "ap-northeast-1"
    alias = "TOKYO"  
}


data "aws_ami" "mumbai_amazon_linux" {
  provider = aws.MUMBAI
  most_recent      = true
  owners           = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}


data "aws_ami" "virginia_amazon_linux" {
  provider = aws.VIRGINIA
  most_recent      = true
  owners           = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

data "aws_ami" "tokyo_amazon_linux" {
  provider  = aws.TOKYO
  most_recent      = true
  owners           = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}
#mumbai server instance

 resource "aws_instance" "my_default_server" {
  provider = aws.MUMBAI
  instance_type = "t2.micro"
  ami = data.aws_ami.mumbai_amazon_linux.id
  tags = {
    name = "default server"

  }
  
}
#virginia server instance

 resource "aws_instance" "VIRGINIA_server" {
  provider = aws.VIRGINIA
  instance_type = "t2.micro"
  ami = data.aws_ami.virginia_amazon_linux.id
  tags = {
    name = "virginia server"

  }
}  

#tokyo server instance
 resource "aws_instance" "tokyo_server" {
  provider = aws.TOKYO
  instance_type = "t2.micro"
  ami = data.aws_ami.tokyo_amazon_linux.id
  tags = {
    name = "tokyo server"

  }
 }
  
 


