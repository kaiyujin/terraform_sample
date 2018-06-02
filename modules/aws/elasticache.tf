resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.service_name}"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  port                 = 6379
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
}
