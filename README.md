# Terraform module for scalable self hosted GitHub action runners on openstack cloud

This terraform module creates the required infrastructure needed to host scalable self hosted GitHub action runners on openstack cloud

Tested on:
- Openstack OVH Public Cloud
- Github runners: Linux X64 based on Ubuntu 20.04 image

## Purpose

- Deploy a pool of self-hosted github runners in an openstack project
- Terraform module creates the minimal following infrastructure:
  - 1 network, subnet and router
  - N instances running cloud-config and install scripts at boot time to configure self-hosted github runners
  - cloud-config and self-hosted github runners install scripts are defined in `terraform/modules/runner/config-scripts` directory
  - github runners register at the first boot with temp token and stay connected until destroyed
  - No inbound ssh is needed to work. Github Runners are configured to access github api with outbound https. No inbound trafic required
  - Optionnal, if Debug is needed , you can activate SSH on a FIP associated on the first runner. (FIP, Lbaas, ssh security group rule are created on demand)

## Setup terraform module

See `sample` directory to see how to use this module

```bash
module "github-runner" {
  source             = "github.com/pli01/terraform-openstack-github-runner//terraform?ref=main"
  ext_net_name       = var.ext_net_name
  default_cidr       = var.default_cidr
  dns_nameservers    = var.dns_nameservers
  runner_count       = var.runner_count
  allow_fip          = var.allow_fip
  keypair_name       = var.keypair_name
  runner_flavor      = var.runner_flavor
  runner_image       = var.runner_image
  runner_volume_type = var.runner_volume_type
  runner_volume_size = var.runner_volume_size
  gh_runner_version  = var.gh_runner_version
  gh_runner_hash     = var.gh_runner_hash
  gh_runner_group    = var.gh_runner_group
  gh_url             = var.gh_url
  gh_token           = var.gh_token
}
```

## Prepare deployment

- Override parameters in `terraform.tfvars`
```
runner_count  = 2             # define number of runner to deploy
runner_flavor = "b2-7"        # define the flavor of runner (CPU/RAM/DISK)
keypair_name  = "runner-key"  # define keyname
#
## optionnal: override default
#
gh_runner_version = "2.298.2" # github runner package version
gh_runner_hash    = "0bfd792196ce0ec6f1c65d2a9ad00215b2926ef2c416b8d97615265194477117" # github runner package checksum
gh_runner_group   = "Default" # Default runner group
#
## only to Debug and access runner ssh (default no SSH to runner)
#
allow_fip  = true            # (true or false) to attached floating ip on the first runner to allow ssh (not needed)
```

- Get temporary token and org name from your ORG settings in /settings/actions/runners/new
- override your secrets with `TF_VAR_`

```bash
export TF_VAR_gh_url=https://github.com/ORG
export TF_VAR_gh_token=<GH_TOKEN>
```

## To deploy runners:
- set your openstack variables `OS_`

```bash
export OS_IDENTITY_API_VERSION
export OS_PASSWORD
export OS_PROJECT_NAME
export OS_USER_DOMAIN_NAME
export OS_PROJECT_ID
export OS_USERNAME
export OS_AUTH_URL
export OS_INTERFACE
export OS_PROJECT_DOMAIN_ID
export OS_REGION_NAME
```

- set your AWS S3 credentials for terraform S3 backend

```bash
export AWS_DEFAULT_REGION
export AWS_S3_ENDPOINT
export AWS_SECRET_KEY
export AWS_ACCESS_KEY
```

- set your secrets and deploy

```bash
# override your secrets
export TF_VAR_gh_url=https://github.com/ORG
export TF_VAR_gh_token=<GH_TOKEN>

terraform init
terraform plan
terraform apply -auto-approve
```

## Results

- Check if runners are registered ,  in your organisation, see `/settings/actions/runners`
- To use self-hosted runners in your workflow: 
```
# Use this YAML in your workflow file for each job
runs-on: self-hosted
```


