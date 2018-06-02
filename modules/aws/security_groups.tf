resource "aws_security_group" "rds" {
  name   = "${terraform.env}-rds"
  vpc_id = "${aws_vpc.vpc.id}"
  description = "RDS Securigy group"
  tags {
    Name = "${terraform.env} for RDS"
  }
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http" {
  name   = "${terraform.env}-http"
  vpc_id = "${aws_vpc.vpc.id}"
  description = "HTTP Securigy group"
  tags {
    Name = "${terraform.env} for HTTP"
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
