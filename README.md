# NO LONGER BEING DEVELOPPED
# Check out [Concourse-Up](https://github.com/EngineerBetter/concourse-up) instead




Concourse Pipelines for deploying a BOSH Director & Concourse on AWS
===================================

Heavily based on the work in:
- https://github.com/EngineerBetter/bosh-concourse-setup
- https://github.com/DigitalInnovation/bosh-concourse-setup

This project achieves the following in a locally deployed pipeline:

- Preparation of an AWS environment for BOSH & Concourse
- Deployment of a new BOSH Director using bosh-init
- Deployment of a new Concourse cluster, or standalone server

Terraform is used to setup the base network and security infrastructure, including an ELB for Concourse.

Requirements
-----

- Run a [local concourse](https://concourse.ci/vagrant.html)
- Install the [fly cli](https://concourse.ci/fly-cli.html)

Table of Contents
-----

1. [Initial setup](/docs/setup.md)
  * Setting up terraform
  * Generating the manifests
  * Using bosh-init to deploy the director
  * Configuring and deploying Concourse with bosh
- [Ops tools](/docs/ops.md)
  * Using bosh ssh to access bosh-managed vms
  * Using ssh to access EC2 instances
  * Using bosh logs to pull down job logs
  * Adding an IP to the whitelist for bosh access
- [Updating](/docs/updating.md)
  * Updating to a new version of Concourse
  * Updating to a new version of Garden
  * Updating the cloud config
  * Modifying the deployment
