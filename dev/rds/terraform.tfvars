db_identifier      = "postgres-instance"
rds_storage        = 20
storage_type       = "gp2"
engine             = "postgres"
engine_version     = "16.1"
db_name            = "mydb"
rds_instance_class = "db.t3.micro"
rds_ingress_port   = 5432
rds_egress_port    = 5432
db_secret_path     = "prod/node-express/db"
tier               = "dev"
