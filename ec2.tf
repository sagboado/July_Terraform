# Configure EC2

resource "aws_instance" "Server_LSCFT" {
  ami = "ami-08cd358d745620807"
  instance_type = var.Instance_type
  key_name = var.Key_Pair
  vpc_security_group_ids = [aws_security_group.LSCFT_Security_Group.id]
  associate_public_ip_address = true
  subnet_id = aws_subnet.public_sub_1.id

  tags ={
    name = "Server_LSCFT"
  }
}