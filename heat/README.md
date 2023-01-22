# openstack heat self hosted github runner

This is a Openstack Heat stack to generate a pool of github runner in a tenant

Optionnal:
- runner instance cab boot on volume or not
- ssh access is disabled by default to github runner
- if enabled, following ressources are generated: fip, lb, and bastion to allow ssh to github runner

To deploy:
- generate a parameter file specific to your environement:

```
# sample.yaml
parameter_defaults:
  # enable boot on volume for instance
  # boot_on_volume: "true"
  # enable SSH to bastion and runners
  # enable_fip: "true"
  runner_env: my-env
  keypair_name: runner
  keypair_public_key: "SSH Pub key"
  ssh_authorized_keys: [
    {"user":"user1", "key": "SSH_Pub_key_FOR User1"}
    ]
  runner_image: "Ubuntu 20.04"
  runner_flavor: s1-2
  runner_vol_size: 30
  runner_vol_type: classic
  GH_URL: "URL repo or orga to add runner pool"
  GH_TOKEN: "TOKEN_used_to_add_runner"
  GH_LABEL: "LABEL_FOR_RUNNER_POOL"
