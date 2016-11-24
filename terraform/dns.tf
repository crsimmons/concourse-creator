resource "aws_route53_record" "concourse" {
   zone_id = "${var.ci_dns_zone_id}"
   name = "${var.ci_hostname}"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.concourse.dns_name}"]
}
