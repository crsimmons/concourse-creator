#SSH into vms

It should be possible to use `bosh ssh` to get into the vms run by bosh (concourse, workers, db) but currently it doesn't seem to work properly.

Standard `ssh` can be used to view any of the vms running in AWS with:
```
ssh -i /path/to/$AWS_KEYPAIR_KEY_NAME vcap@$INSTANCE_ELASTIC_IP
```