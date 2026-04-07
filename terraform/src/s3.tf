# S3 Bucket Configuration
# Code smell: hardcoded values, insecure settings

resource "aws_s3_bucket" "app_bucket" {
  bucket = "app-bucket-${var.environment}"  # Code smell: hardcoded naming

  tags = {
    Name        = "app-bucket"
    Environment = var.environment
  }
}

# Code smell: bucket without versioning, no encryption
resource "aws_s3_bucket" "data_bucket" {
  bucket = "data-bucket-${var.environment}"

  tags = {
    Name        = "data-bucket"
    Environment = var.environment
  }
}

# Code smell: public access block not configured for sensitive bucket
resource "aws_s3_bucket_public_access_block" "app_bucket_access" {
  bucket = aws_s3_bucket.app_bucket.id

  # Code smell: all false - very permissive
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Code smell: overly permissive bucket policy
resource "aws_s3_bucket_policy" "app_bucket_policy" {
  bucket = aws_s3_bucket.app_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::app-bucket-${var.environment}/*"
    }
  ]
}
POLICY
}