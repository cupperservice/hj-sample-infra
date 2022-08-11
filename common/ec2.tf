
resource "aws_instance" "bastion" {
  ami = "${var.bastion.image_id}"
  instance_type = "t2.micro"
  key_name = "${var.bastion.key_name}"
  subnet_id =  aws_subnet.your-sub-pub1.id
  associate_public_ip_address = "true"
  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]
  tags = {
    Name = "bastion"
  }
  user_data = <<EOF
  #!/bin/bash
  yum update -y
  yum install -y git
  EOF
}

resource "aws_instance" "template" {
  ami = "${var.template.image_id}"
  instance_type = "t2.micro"
  key_name = "${var.template.key_name}"
  subnet_id =  aws_subnet.your-sub-pri1.id
  associate_public_ip_address = "true"
  vpc_security_group_ids = [
    aws_security_group.template.id
  ]
  tags = {
    Name = "template"
  }
  user_data = <<EOF
  #!/bin/bash
  yum update -y
  EOF
}
