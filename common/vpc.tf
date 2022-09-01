// VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "your-vpc"
  }
}

// Subnet
resource "aws_subnet" "your-sub-pub1" {
  vpc_id = aws_vpc.main.id

  availability_zone = "${var.az1}"

  cidr_block = "10.0.10.0/24"

  tags = {
    Name = "your-sub-pub1"
  }
}

resource "aws_subnet" "your-sub-pub2" {
  vpc_id = aws_vpc.main.id

  availability_zone = "${var.az2}"

  cidr_block = "10.0.20.0/24"

  tags = {
    Name = "your-sub-pub2"
  }
}

resource "aws_subnet" "your-sub-pri1" {
  vpc_id = aws_vpc.main.id

  availability_zone = "${var.az1}"

  cidr_block = "10.0.15.0/24"

  tags = {
    Name = "your-sub-pri1"
  }
}

resource "aws_subnet" "your-sub-pri2" {
  vpc_id = aws_vpc.main.id

  availability_zone = "${var.az2}"

  cidr_block = "10.0.25.0/24"

  tags = {
    Name = "your-sub-pri2"
  }
}

// Internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "your-sub-gw"
  }
}

// Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "your-sub-public"
  }
}

resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.public.id
  gateway_id = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "your-sub-pub1" {
  subnet_id = aws_subnet.your-sub-pub1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "your-sub-pub2" {
  subnet_id = aws_subnet.your-sub-pub2.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "your-sub-private"
  }
}

resource "aws_route" "private" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.private.id
  gateway_id = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "your-sub-pri1" {
  subnet_id = aws_subnet.your-sub-pri1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "your-sub-pri2" {
  subnet_id = aws_subnet.your-sub-pri2.id
  route_table_id = aws_route_table.private.id
}

// Security Group for bastion
resource "aws_security_group" "bastion" {
  name = "bastion"
  description = "for work server"
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "bastion" {
  security_group_id = aws_security_group.bastion.id

  type = "ingress"

  from_port = 22
  to_port = 22
  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}


// Security Group for web
resource "aws_security_group" "web" {
  name = "web"
  description = "for web server"
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "web" {
  security_group_id = aws_security_group.web.id

  type = "ingress"

  from_port = 80
  to_port = 80
  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

// Security Group for template
resource "aws_security_group" "template" {
  name = "template"
  description = "for template server"
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "template_from_web" {
  security_group_id = aws_security_group.template.id

  type = "ingress"

  from_port = 8080
  to_port = 8080
  protocol = "tcp"

  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "template_from_bastion" {
  security_group_id = aws_security_group.template.id

  type = "ingress"

  from_port = 22
  to_port = 22
  protocol = "tcp"

  source_security_group_id = aws_security_group.bastion.id
}

// Security Group for app
resource "aws_security_group" "app" {
  name = "app"
  description = "for application server"
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "app" {
  security_group_id = aws_security_group.app.id

  type = "ingress"

  from_port = 8080
  to_port = 8080
  protocol = "tcp"

  source_security_group_id = aws_security_group.web.id
}

// Security Group for database
resource "aws_security_group" "db" {
  name = "db"
  description = "for database server"
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "db" {
  security_group_id = aws_security_group.db.id

  type = "ingress"

  from_port = 3306
  to_port = 3306
  protocol = "tcp"

  source_security_group_id = aws_security_group.app.id
}


resource "aws_security_group_rule" "db_from_template" {
  security_group_id = aws_security_group.db.id

  type = "ingress"

  from_port = 3306
  to_port = 3306
  protocol = "tcp"

  source_security_group_id = aws_security_group.template.id
}
