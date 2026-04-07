# EC2 Instance Configuration
# Code smell: hardcoded values, missing variables

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"  # Hardcoded AMI ID (code smell)
  instance_type = "t2.micro"

  # Code smell: hardcoded subnet
  subnet_id = "subnet-01234567890abcdef"

  # Code smell: hardcoded security groups
  vpc_security_group_ids = ["sg-0123456789abcdef"]

  tags = {
    Name        = "app-server-${var.environment}"
    Environment = var.environment
    # Code smell: hardcoded owner
    Owner       = "devops@example.com"
  }

  # Code smell: root volume without encryption
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
    # Missing: encrypted = true
  }

  # Code smell: inline user data script
  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from Terraform" > /var/www/html/index.html
              EOF
}

# Code smell: hardcoded IAM role
resource "aws_iam_role" "app_role" {
  name = "app-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Code smell: inline policy instead of separate file
resource "aws_iam_role_policy" "app_policy" {
  name = "app-instance-policy"
  role = aws_iam_role.app_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:*"],
      "Resource": "*"
    }
  ]
}
EOF
}