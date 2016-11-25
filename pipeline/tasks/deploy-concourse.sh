#!/bin/bash

./bin/make_tfvars.sh
make infra

./bin/make_manifest_bosh-init.sh
bosh-init deploy bosh-director.yml
bosh target $(terraform output eip)
./bin/make_cloud_config.sh
bosh update cloud-config aws-cloud.yml

./bin/make_manifest_concourse.sh