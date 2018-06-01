resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.3"
  instance_class       = "db.t2.micro"
  name                 = "${terraform.env}${var.service_name}"
  identifier           = "${terraform.env}${var.service_name}"
  username             = "postgres"
  password             = "foobarbaz"
  parameter_group_name = "default.postgres10"
  vpc_security_group_ids = [
    "${aws_security_group.rds.id}",
  ]
  db_subnet_group_name = "${aws_db_subnet_group.main.name}"
  backup_window = "19:00-19:30"
  skip_final_snapshot = true
/*
*/
}
