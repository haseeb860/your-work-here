provider "aws" {
  region = "us-east-1"  # Change the region as per your requirement
}

resource "aws_instance" "web" {
  ami                    = "ami-0c55b159cbfafe1f0"  # Ubuntu AMI (change as needed)
  instance_type          = "t2.micro"
  key_name               = "your-key-pair"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = file("user_data.sh")
  
  tags = {
    Name = "Terraform-Nginx-Server"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this in production
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
