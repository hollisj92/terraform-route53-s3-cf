# access keys

variable "region" {
  description = "Chosen region for deployment"
  type = string
  sensitive = true
}

variable "access_key" {
  description = "General access key for AWS account."
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "General secret key for AWS account."
  type        = string
  sensitive   = true
}

# r53

variable "domain_name" {
    description = "Domain name for existing R53 - plus subdomain for htis proj"
    type = string
    sensitive = true
}

variable "domain_name_redirect" {
    description = "Domain name for existing R53 - plus subdomain for htis proj"
    type = string
    sensitive = true
}

variable "zone_id" {
    description = "Hosted zone ID - pre-existing zone when DNS is purchased."
    type = string
    sensitive = true
}

# certificate validation

variable "certificate_valiation_arn" {
  description = "Certificate Validation ARN - Pre-made for Route53"
  type = string
  sensitive = true
}

# project variables for cloudwatch

variable "proj_prefix" {
  description = "Project name"
  type = string
  sensitive = true
}

variable "env_prefix" {
  description = "Project environment - Prod/Test/Dev"
  type = string
  sensitive = true
}

variable "team" {
  description = "project team"
  type = string
  sensitive = true
}
