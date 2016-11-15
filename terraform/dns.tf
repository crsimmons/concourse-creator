/*resource "aws_route53_zone" "dachs-dog" {
   name = "dachs.dog"
}*/

/*resource "aws_route53_record" "www-dachs-dog-CNAME" {
   zone_id = "${aws_route53_zone.dachs-dog.zone_id}"
   name = "www.dachs.dog"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_s3_bucket.www-dachs-dog.website_endpoint}"]
}*/

resource "aws_route53_record" "concourse" {
   zone_id = "${var.ci_dns_zone_id}"
   name = "${var.ci_hostname}"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.concourse.dns_name}"]
}
