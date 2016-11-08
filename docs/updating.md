#Updating to a new version of Concourse

As the deployment is managed by BOSH, updating the concourse version is easy and requires no downtime.

The deployment manifest `concourse.yml` will use the latest release that has been uploaded.

When a new version of [Concourse](https://concourse.ci/downloads.html) becomes available you first need to upload the latest release:
```
bosh upload release https://bosh.io/d/github.com/concourse/concourse
```

Now make sure the correct deployment manifest is referenced:
```
bosh deployment concourse.yml
```

And finally deploy:
```
bosh deploy
```

This will take a few minutes to complete.

#Updating to a new version of Garden

Same as above with Concourse but instead run
```
bosh upload release https://bosh.io/d/github.com/cloudfoundry/garden-runc-release
```

#Changing the cloud config

The definitions such as vm types and disk sizes are found in `aws-cloud.yml`.  Upon making edits there, the changes can be deployed by:
```
bosh update cloud-config aws-cloud.yml
bosh deployment concourse.yml
bosh deploy
```

#Changing the deployment

Changes made to `concourse.yml` (such as adding worker vms or changing keys) can be deployed with a simple:
```
bosh deployment concourse.yml
bosh deploy
```