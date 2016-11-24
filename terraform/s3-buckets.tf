resource "aws_s3_bucket" "setup-files" {
    bucket = "concourse-setup-files"
    acl = "private"
    region = "eu-west-1"
}
