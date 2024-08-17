// This is a development instance, hence no user data is provided

data "aws_security_group" "openvpn_sg" {
  name = var.access_server_sg_name
  vpc_id = data.aws_vpc.selected.id
}

resource "aws_instance" "openaiflask" {
  depends_on = [ aws_security_group.openaiflask, aws_iam_instance_profile.openaiflask ]
# count                  = 2
  ami                    = var.openaiflask_ami_id
  instance_type          = "t3.large"
  iam_instance_profile   = aws_iam_instance_profile.openaiflask.name
  vpc_security_group_ids = [aws_security_group.openaiflask.id, data.aws_security_group.openvpn_sg.id]
  key_name               = var.key_name
  subnet_id              = data.aws_subnets.amazon_linux[0].id 
    
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name = "openaiflask-quickstart-dev-instance"
  }
}

