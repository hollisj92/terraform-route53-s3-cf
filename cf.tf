# Cloudfront S3 for redirect to www.


resource "aws_cloudfront_distribution" "www_s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.s3_react_bucket.website_endpoint
    origin_id = "S3-.${var.domain_name}"
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }
  

  enabled = true
  is_ipv6_enabled = true
  
  aliases = [var.domain_name]

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "S3-.${var.domain_name}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }

      headers = ["Origin"]
    }

    viewer_protocol_policy = "allow-all"
    min_ttl = 30
    default_ttl = 86400
    max_ttl = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_valiation_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Env: "${var.env_prefix}"
    Service: "${var.env_prefix}-${var.proj_prefix}"
    Name : "${var.env_prefix}-cf-distribution"
    Role: "${var.env_prefix}-cf-distribution"
    Team: "team-${var.team}"
  }
}

resource "aws_cloudfront_distribution" "redirect_s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.s3_react_bucket_redirect.website_endpoint
    origin_id = "S3-.${var.domain_name_redirect}"
    custom_origin_config {
      http_port = 80
      https_port = 443

      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled = true
  is_ipv6_enabled = true

  aliases = [var.domain_name_redirect]

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "S3-.${var.domain_name_redirect}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }

      headers = ["Origin"]
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 30
    default_ttl = 86400
    max_ttl = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_valiation_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Env: "${var.env_prefix}"
    Service: "${var.env_prefix}-${var.proj_prefix}"
    Name : "${var.env_prefix}-cf-distribution-redirect"
    Role: "${var.env_prefix}-cf-distribution-redirect"
    Team: "team-${var.team}"
  }

}