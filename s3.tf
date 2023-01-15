# main s3 bucket - reseource/acl/policy

resource "aws_s3_bucket" "s3_react_bucket" {
  bucket = var.domain_name

  website {
    index_document = "index.html"
  }

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }  

  tags = {
    Environment = "PROD"
  }
}

resource "aws_s3_bucket_acl" "cloudfront_acl" {
  bucket = aws_s3_bucket.s3_react_bucket.id
  acl    = "public-read"

}

resource "aws_s3_bucket_public_access_block" "s3_acl_pubaccess" {
  bucket = aws_s3_bucket.s3_react_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "s3_react_policy" {  
  bucket = aws_s3_bucket.s3_react_bucket.id   
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "Policy1668999804673",
  "Statement": [
      {
          "Sid": "Stmt1668999802502",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject",
              "s3:PutObject"
          ],
          "Resource": "arn:aws:s3:::${var.domain_name}/*"
      }
  ]
}
POLICY
}


# 
# 
# 
# redirect s3 bucket - reseource/acl/policy
# 
# 
# 

resource "aws_s3_bucket" "s3_react_bucket_redirect" {
  bucket = var.domain_name_redirect
  

  website {
    redirect_all_requests_to = "${var.domain_name}"
    }


  tags = {
    Environment = "PROD"
  }
}

resource "aws_s3_bucket_acl" "s3_cloudfront_acl" {
  bucket = aws_s3_bucket.s3_react_bucket.id
  acl    = "private"
}




