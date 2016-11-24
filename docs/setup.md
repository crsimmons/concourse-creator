Initial Setup - Terraform, Bosh, and Concourse
==============================================

Populate `pipeline/vars/pipeline_vars.yml` appropriately.

TODO: describes vars

```
fly -t lite set-pipeline -p cc-deploy -c pipeline/deploy -l pipeline/vars/pipeline_vars.yml
fly -t lite unpause-pipeline -p cc-deploy
```

Pipeline will not trigger automatically.  Go into your concourse's UI and start
the task by clicking the `+` in the top right.

Congratulations, you should now be able to see your new CI server at https://your-concourse-url.
