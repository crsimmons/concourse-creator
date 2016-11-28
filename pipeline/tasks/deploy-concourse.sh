#!/bin/bash

./bin/make_tfvars.sh
make infra

# I'm so sorry...
mv ../private_key/${AWS_KEYPAIR_KEY_NAME}{-$(cat ../private_key/version),}.pem

./bin/make_manifest_bosh-init.sh
bosh-init deploy bosh-director.yml || make destroy
bosh target $(terraform output eip)
./bin/make_cloud_config.sh
bosh update cloud-config aws-cloud.yml

./bin/make_manifest_concourse.sh