# Configure Security Group

resource "aws_security_group" "LSCFT_Security_Group" {
  name        = "allow_HTTP"
  description = "Allow_HTTP inbound traffic (LSCFT_Security_Group_for_private_Subnet inbound traffic)"
  vpc_id      = aws_vpc.LSCFT_VPC.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  ##ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  ## ipv6_cidr_blocks = ["::/0"]
  }

egress {
    from_port        = 22
    to_port          = 22
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  # ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_http"
  }
}