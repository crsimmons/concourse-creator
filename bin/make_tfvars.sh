#!/bin/bash

cat >terraform/terraform.tfvars <<EOF
boshers = $BOSHERS
ssl_cert_arn="$SSL_CERT_ARN"
ci_dns_zone_id="$CI_DNS_ZONE_ID"
ci_hostname="$CI_HOSTNAME"
aws_access_key="$AWS_ACCESS_KEY_ID"
aws_secret_key="$AWS_SECRET_ACCESS_KEY"
EOF
