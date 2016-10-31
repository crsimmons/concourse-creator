#variable "aws_access_key_id" {
#type = "string"
#}
#variable "aws_secret_access_key" {
#type = "string"
#}
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
