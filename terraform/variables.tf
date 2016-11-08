variable "aws_region" {
    type = "string"
    default =  "eu-west-1"
}
variable "boshers" {
  type = "list"
}
variable "ci_hostname" {
type = "string"
}
variable "ci_dns_zone_id" {
type = "string"
}
variable "ssl_cert_arn" {
type = "string"
}
