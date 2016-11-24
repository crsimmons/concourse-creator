#!/bin/bash
#

: "${DB_PASSWORD:?Need to set DB_PASSWORD non-empty}"
: "${CONCOURSE_URL:?Need to set CONCOURSE_URL non-empty}"
: "${GITHUB_ORG:?Need to set GITHUB_ORG non-empty}"
: "${GITHUB_CLIENT_ID:?Need to set GITHUB_CLIENT_ID non-empty}"
: "${GITHUB_CLIENT_SECRET:?Need to set GITHUB_CLIENT_SECRET non-empty}"
: "${DISK_TYPE:?Need to set DISK_TYPE from Cloud Config}"

DIRECTOR_UUID=`bosh status --uuid`

echo "director_uuid = $DIRECTOR_UUID"
echo "concourse url = $CONCOURSE_URL"
echo "GitHub Org = $GITHUB_ORG"

cat >concourse.yml <<YAML
---
name: concourse

director_uuid: $DIRECTOR_UUID

releases:
- name: concourse
  version: latest
- name: garden-runc
  version: latest

stemcells:
- alias: trusty
  os: ubuntu-trusty
  version: latest

instance_groups:
- name: concourse
  instances: 1
  vm_type: concourse_standalone
  stemcell: trusty
  azs: [z1]
  networks: [{name: ops_services}]
  jobs:
  - name: atc
    release: concourse
    properties:
      # replace with your CI's externally reachable URL e.g https://blah
      external_url: $CI_HOSTNAME
      # configure GitHub auth
      github_auth:
        authorize:
        - organization: $GITHUB_ORG
          teams: [platform-engineering]
        client_id: $GITHUB_CLIENT_ID
        client_secret: $GITHUB_CLIENT_SECRET

      postgresql_database: &atc_db atc
  - name: tsa
    release: concourse
    properties: {}

- name: db
  instances: 1
  vm_type: concourse_db
  stemcell: trusty
  # choose a disk type from the cloud-config
  persistent_disk_type: $DISK_TYPE
  azs: [z1]
  networks: [{name: ops_services}]
  jobs:
  - name: postgresql
    release: concourse
    properties:
      databases:
      - name: *atc_db
        # make up a role and password
        role: dbrole
        password: $DB_PASSWORD

- name: worker
  instances: 2
  vm_type: concourse_worker
  stemcell: trusty
  azs: [z1]
  networks: [{name: ops_services}]
  jobs:
  - name: groundcrew
    release: concourse
    properties: {}

  - name: baggageclaim
    release: concourse
    properties: {}

  - name: garden
    release: garden-runc
    properties:
      garden:
        listen_network: tcp
        listen_address: 0.0.0.0:7777

update:
  canaries: 1
  max_in_flight: 1
  serial: false
  canary_watch_time: 1000-60000
  update_watch_time: 1000-60000
