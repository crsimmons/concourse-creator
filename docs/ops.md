#SSH into vms

You can use `bosh ssh` to access the vms being managed by the bosh director

```
bosh ssh --gateway_host <bosh director elastic IP> --gateway_user vcap --gateway_identity_file ~/path/to/key.pem
```

Standard `ssh` can be used to view any of the vms running in AWS with:
```
ssh -i /path/to/$AWS_KEYPAIR_KEY_NAME vcap@<instance elastic IP>
```

#Getting logs
Logs for specific jobs (ie atc, tsa, baggageclaim, etc as defined in concourse.yml) can be pulled down using
```
bosh logs <job> <instance-id>
```
where the `instance-id` is the string in `()` under VM in the `bosh vms` output
```
$ bosh vms
Acting as user 'admin' on 'dachs-bosh'
Deployment 'concourse'

Director task 245

Task 245 done

+----------------------------------------------------+---------+----+----------------------+-----------+
| VM                                                 | State   | AZ | VM Type              | IPs       |
+----------------------------------------------------+---------+----+----------------------+-----------+
| concourse/0 (<instance-id>)                        | running | z1 | concourse_standalone | 10.0.10.6 |
| db/0 (<instance-id>)                               | running | z1 | concourse_db         | 10.0.10.7 |
| worker/0 (<instance-id>)                           | running | z1 | concourse_worker     | 10.0.10.8 |
+----------------------------------------------------+---------+----+----------------------+-----------+
```

#Adding an IP to the Bosh whitelist
Add the appropriate CIDR block to the `boshers` array in `terraform/terraform.tfvars` then run
```
make infra
```