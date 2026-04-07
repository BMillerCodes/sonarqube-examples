# RDS Database Configuration
# Code smell: hardcoded credentials, missing encryption

resource "aws_db_instance" "app_database" {
  identifier     = "app-database-${var.environment}"
  engine         = "mysql"
  engine_version = "8.0"

  # Code smell: hardcoded credentials (should use secrets manager)
  db_name  = "appdb"
  username = "admin"
  password = "Password123!"  # Code smell: hardcoded password in plain text

  # Code smell: publicly accessible
  publicly_accessible = true

  # Code smell: missing storage encryption
  # storage_encrypted = true  # Missing!

  # Code smell: missing backup configuration
  # backup_retention_period = 7  # Missing!

  db_subnet_group_name   = aws_db_subnet_group.app.name
  vpc_security_group_ids = [aws_security_group.database.id]

  tags = {
    Name        = "app-database"
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "app" {
  name       = "app-db-subnet-group"
  subnet_ids = ["subnet-01234567890abcdef", "subnet-fedcba9876543210"]

  tags = {
    Name = "app-db-subnet-group"
  }
}

# Code smell: database security group allows all traffic
resource "aws_security_group" "database" {
  name        = "database-sg"
  description = "Security group for RDS database"
  vpc_id      = "vpc-01234567890abcdef"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Code smell: allows all IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-sg"
  }
}