#!/bin/bash

cat >terraform/terraform.tfvars <<EOF
boshers = $BOSHERS
ssl_cert_arn="$SSL_CERT_ARN"
ci_dns_zone_id="$CI_DNS_ZONE_ID"
ci_hostname="$CI_HOSTNAME"
EOF
