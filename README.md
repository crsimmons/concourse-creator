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

Ensure you have created a `terraform/terraform.tfvars` file with your variables, or set suitable [environment variables](https://www.terraform.io/docs/configuration/variables.html). An example tfvars file can be found in `terraform/terraform.tfvars.example`

Assumptions
-----

You already have:

- A Route53 Zone in AWS.
- An EC2 SSH keypair
- An SSL certificate in AWS for your Concourse ELB

Usage
-----

Set your desired AWS region in `terrform/variables.tf`. Ensure terraform is in your path, then apply the configuration to prepare the IaaS for BOSH and Concourse:

```
cd terraform/
terraform apply
```

Populate `cloud_vars.yml` with the appropriate values for each variable.

Then create the `bosh-director.yml` manifest:
```
yml2env vars/cloud_vars.yml ./bin/make_manifest_bosh-init.sh
```

You are ready to deploy the BOSH Director
```
bosh-init deploy bosh-director.yml
```

Go and make a cup of tea.

Once the director is deployed, target it.
```
bosh target <your EIP address>
```

Then create `aws-cloud.yml` with:
```
yml2env vars/cloud_vars.yml ./bin/make_cloud_config.sh
```

Now you need to apply your cloud-config for AWS.

Remember to set your chosen AZ and the subnet-id output by terraform in `aws-cloud.yml`.

```
bosh update cloud-config aws-cloud.yml
```

Create a new OAuth application in GitHub as described [here](http://concourse.ci/authentication.html). The manifest assumes the existance of a 'CI' team that contains your authorised users, so create that too. Also, set a database password and external URL for your deployment.

Now set the appropriate values in `vars/concourse_vars.yml`

Then create a concourse manifest for a single server deployment:
```
yml2env vars/concourse_vars.yml ./bin/make_manifest_concourse.sh
```

Upload the necessary stemcell & releases, then deploy concourse:
```
bosh upload stemcell https://bosh.io/d/stemcells/bosh-aws-xen-hvm-ubuntu-trusty-go_agent
bosh upload release https://bosh.io/d/github.com/concourse/concourse
bosh upload release https://bosh.io/d/github.com/cloudfoundry-incubator/garden-runc-release
bosh deployment concourse.yml
bosh deploy
```

Congratulations, you should now be able to see your new CI server at https://your-concourse-url.
