provider "aws" {
  region = var.region
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "db_secret" {
  name        = "mydbsecret"
  description = "RDS MySQL Database Password"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
  })
}

resource "aws_db_instance" "default" {
  identifier             = var.db_instance_identifier
  allocated_storage       = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = random_password.db_password.result
  db_name                = var.db_name
  skip_final_snapshot    = true
  vpc_security_group_ids = ["sg-00fc8b71b25ed9a15"]  
}

resource "aws_security_group_rule" "allow_mysql" {
  type              = "ingress"
  from_port        = 3306
  to_port          = 3306
  protocol         = "tcp"
  security_group_id = "sg-00fc8b71b25ed9a15"  
  cidr_blocks      = ["0.0.0.0/0"]  
}


