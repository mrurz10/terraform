provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_instance" "my_server_web" {
    ami = "ami-0fd05997b4dff7aac"
   instance_type = "t2.micro"
   vpc_security_group_ids = [aws_security_group.general.id]
   tags = { name = "myserver" }
     depends_on = [ aws_instance.my_server_DB,aws_instance.my_server_APP ]
}


resource "aws_instance" "my_server_APP" {
    ami = "ami-0fd05997b4dff7aac"
   instance_type = "t2.micro"
   vpc_security_group_ids = [aws_security_group.general.id]
   tags = { name = "myserver-APP" }
   depends_on = [ aws_instance.my_server_DB ]
   
}



resource "aws_instance" "my_server_DB" {
    ami = "ami-0fd05997b4dff7aac"
   instance_type = "t2.micro"
   vpc_security_group_ids = [aws_security_group.general.id]
   tags = { name = "myserver-DB" }
   
}


resource "aws_security_group" "general" {
    name = "my-security-group"
     description = "Allow inbound traffic on common ports"
 
    dynamic "ingress" {
        for_each = ["80","443","22","3389"]
        content {
         from_port = ingress.value
         to_port = ingress.value
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]

        }
      
    }
  

 
   egress {

    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

}

output "instance_ids" {
    value = [
        aws_instance.my_server_DB.id,
        aws_instance.my_server_APP.id,
        aws_instance.my_server_web.id
    ] 
  
}