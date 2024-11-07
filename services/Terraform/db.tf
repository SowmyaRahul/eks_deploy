#create the rds instance
resource "aws_db_instance" "db_instance" {
  engine         = "mysql"
  engine_version = "8.0.35"
  multi_az       = false

  identifier             = "project1"
  username               = "project1uname"
  password               = "project1pwd"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  publicly_accessible    = false
  deletion_protection    = true
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  availability_zone      = aws_subnet.subnet_az2_private.availability_zone
  db_name                = "project1dbname"
  skip_final_snapshot    = true
}



# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "database security group"
  description = "enable mysql/aurora access on port 3306"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "mysql/aurora access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.db_instance.id]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database security group"
  }
}


# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "db-secure-subnets"
  subnet_ids  = [aws_subnet.subnet_az1_private.id, aws_subnet.subnet_az2_private.id]
  description = "rds in secure subnet"

  tags = {
    Name = "db-secure-subnets"
  }
}

