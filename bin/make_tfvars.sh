#!/bin/bash

cat >terraform/terraform.tfvars <<EOF
boshers = $BOSHERS
ssl_cert_arn="$SSL_CERT_ARN"
ci_dns_zone="$CI_DNS_ZONE"
ci_hostname="$CI_HOSTNAME"
EOF
