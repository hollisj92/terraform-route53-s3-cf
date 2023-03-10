
# aws route54 records/subdomains

data "aws_route53_zone" "current_domain" {
  zone_id = var.zone_id
  private_zone = false

  tags = {
    Env: "${var.env_prefix}"
    Service: "${var.env_prefix}-${var.proj_prefix}"
    Name : "${var.env_prefix}-r53-zone"
    Role: "${var.env_prefix}-r53-zone"
    Team: "team-${var.team}"
  }
}

# main record

resource "aws_route53_record" "root_s3_route" {
  zone_id = data.aws_route53_zone.current_domain.zone_id
  name    = var.domain_name
  type    = "A"


  alias {
    name = "${aws_cloudfront_distribution.www_s3_distribution.domain_name}"
    zone_id = aws_cloudfront_distribution.www_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# redirect record

resource "aws_route53_record" "redirect_s3_route" {
  zone_id = data.aws_route53_zone.current_domain.zone_id
  name    = var.domain_name_redirect
  type    = "A"


  alias {
    name = "${aws_cloudfront_distribution.redirect_s3_distribution.domain_name}"
    zone_id = aws_cloudfront_distribution.redirect_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}