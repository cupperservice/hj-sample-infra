# RDS
resource "aws_db_subnet_group" "hj-db-subnet-group" {
    name        = "hj-db-subnet-group"
    subnet_ids  = ["${aws_subnet.your-sub-pri1.id}", "${aws_subnet.your-sub-pri2.id}"]
    tags = {
        Name = "hj-db-subnet-group"
    }
}

resource "aws_rds_cluster" "hj-db-cluster" {
  cluster_identifier_prefix       = "hj-db-cluster"
  database_name                   = "${var.database.db_name}"
  port                            = "${var.database.port}"

  engine                          = "${var.database.engine}"
  engine_version                  = "${var.database.engine_version}"
  engine_mode                     = "provisioned"

  master_username                 = "${var.database.username}"
  master_password                 = "${var.database.password}"

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.hj-db-cluster-parameter-group.name
  db_subnet_group_name            = aws_db_subnet_group.hj-db-subnet-group.name
  vpc_security_group_ids          = [aws_security_group.db.id]

  deletion_protection             = false
  skip_final_snapshot             = true
}

resource "aws_rds_cluster_parameter_group" "hj-db-cluster-parameter-group" {
  name    = "hj-db-cluster-parameter-group"
  family  = "aurora-mysql5.7"

  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }
}

resource "aws_rds_cluster_instance" "hj-db-instance" {
  count                   = "${var.database.num_of_instances}"
  identifier              = "hj-db-instance-${count.index}"
  cluster_identifier      = aws_rds_cluster.hj-db-cluster.id

  engine                  = aws_rds_cluster.hj-db-cluster.engine
  engine_version          = aws_rds_cluster.hj-db-cluster.engine_version

  instance_class          = "${var.database.instance_class}"

  db_subnet_group_name    = aws_db_subnet_group.hj-db-subnet-group.name
  db_parameter_group_name = aws_db_parameter_group.hj-db-parameter-group.name
}

resource "aws_db_parameter_group" "hj-db-parameter-group" {
  name    = "hj-db-parameter-group"
  family  = "aurora-mysql5.7"

  parameter {
    name  = "wait_timeout"
    value = 30
  }
}
