BOSH Director & Concourse Bootstrap
===================================

This project achieves the following:

- Preparation of an AWS environment for BOSH & Concourse
- Deployment of a new BOSH Director using bosh-init
- Deployment of a new Concourse cluster, or standalone server

Terraform is used to setup the base network and security infrastructure, including an ELB for Concourse.

Requirements
-----

- Install [terraform](https://www.terraform.io/intro/getting-started/install.html)
- Install [bosh-init](https://bosh.io/docs/install-bosh-init.html)
- Install the [bosh_cli](https://bosh.io/docs/bosh-cli.html)
- Install the [yml2env tool](https://github.com/EngineerBetter/yml2env)

Table of Contents
-----

1. [Initial setup](/docs/setup.md)
  * Setting up terraform
  * Using bosh-init to deploy the director
  * Configuring and deploying Concourse with bosh
- [Ops tools](/docs/ops.md)
  * Using bosh ssh to access bosh-managed vms
  * Using ssh to access EC2 instances
  * Using bosh logs to pull down job logs
  * Adding an IP to the whitelist for bosh access
- [Updating Concourse](/docs/updating.md)
  * Updating to a new version of Concourse
  * Updating to a new version of Garden
  * Updating the cloud config


Credits
-----

Many thanks to [EngineerBetter](http://www.engineerbetter.com/) for the original [tutorial](https://github.com/EngineerBetter/bosh-concourse-setup) of which this is a fork and for the yml2env tool.