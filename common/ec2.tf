
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
sudo yum remove -y mariadb-libs
sudo yum localinstall -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo yum-config-manager --disable mysql57-community
sudo yum-config-manager --enable mysql80-community
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum install -y mysql-community-client
EOF
}

resource "aws_instance" "template" {
  ami = "${var.template.image_id}"
  instance_type = "t2.micro"
  iam_instance_profile = "EMR_EC2_DefaultRole"
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
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
yum install -y --enablerepo=nodesource nodejs
yum install -y amazon-cloudwatch-agent
cat > "/opt/aws/amazon-cloudwatch-agent/bin/config.json" <<EOF2
{
  "agent": {
    "run_as_user": "root"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/opt/appsvr/logs/application.log",
            "log_group_name": "hj-sample-app/application.log",
            "log_stream_name": "{instance_id}",
            "retention_in_days": 1
          }
        ]
      }
    }
  }
}
EOF2
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file://opt/aws/amazon-cloudwatch-agent/bin/config.json
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start
EOF
}
