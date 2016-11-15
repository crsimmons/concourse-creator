## Notes from the BOSH/Concourse pairing session with Phillip Bailey and Diogo Lemos

1. Git clone https://github.com/DigitalInnovation/bosh-concourse-setup.git

1. Create local branch

1. atom .

1. Update terraform/terraform.tfvars
    1. `boshers` - source IPs that will interact with Bosh director (i.e. Alicudi, trasimeno, saline ..etc)

1. Validate the Assumptions:
    1. Route53 zone in AWS
        1. Go to R53 in AWS Test Account
        2. Check available hosted zones
        3. Note down the zone id
        4. Note down the cert arn
    2. An EC2 SSH Keypair
        1. create a key pair with name `boshconcourse`

1. S3 bucket for `tfstate` (`FIXME` : create manually if found via Terraform)
```
.terraform/terraform.tfstate:
     terraform remote config \
       -backend=S3 \
       -backend-config="bucket=dachs-terraform" \
       -backend-config="key=terraform.tfstate" \
       -backend-config="region=eu-west-1" \
       -backend-config="encrypt=true" \
       -backend-config="acl=private”
```
1. `FIXME` : How to run make file with sts:assumerole

1. `FIXME` : Create `make destroy`

1. `make plan` and if it works `make apply`

1. Commented `dns.tf` - commented

1. Zone is hardcoded in `dns.tf`. But since we defined `ci_dns_zone_id`  in `terraform.tfvars` we can use this in the `resource` descriptors

1. `FIXME` : Add the following command into make file so that the correct `tdstate` path is used in the `.sh` script.
```yml2env vars/cloud_vars.yml ./bin/make_manifest_bosh-init.sh
```
1. `FIXME` : Find correct AZ based on the where the subnets are created by terraform and set the correct AZ in `cloud_vars.yml`. Otherwise
`yml2env vars/cloud_vars.yml ./bin/make_manifest_bosh-init.sh`will fail.

1. `FIXME` : define bosh director username in README for `bosh target`

1. Remove `Remember to set your chosen AZ and the subnet-id output by terraform in aws-cloud.yml`

1. `FIXME`: `vm_types` on `compilation` section. Should refer to something defined in VM types section to use for creating compilation VMs.

  ```
  compilation:
    workers: 5
    reuse_compilation_vms: true
    az: z1
    vm_type: large
    network: default
  ```

1. `FIXME` : Add `DISK_TYPE` env var to `concourse_vars.yml`
