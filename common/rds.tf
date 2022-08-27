# RDS
resource "aws_db_subnet_group" "praivate-db" {
    name        = "praivate-db"
    subnet_ids  = ["${aws_subnet.your-sub-pri1.id}", "${aws_subnet.your-sub-pri2.id}"]
    tags = {
        Name = "praivate-db"
    }
}

resource "aws_db_instance" "hj-db" {
  identifier              = "hj-db"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "${var.database.engine}"
  engine_version          = "${var.database.engine_version}"
  instance_class          = "${var.database.instance_class}"
  db_name                 = "${var.database.db_name}"
  username                = "${var.database.username}"
  password                = "${var.database.password}"
  vpc_security_group_ids  = ["${aws_security_group.db.id}"]
  db_subnet_group_name    = "${aws_db_subnet_group.praivate-db.name}"
  skip_final_snapshot     = true
}
