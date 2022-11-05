# terraform openstack github runner

- Get token from /settings/actions/runners/new
- Set params
- deploy runner

```bash
# modify terraform.tfvars to increase runner count

# override your secrets
export TF_VAR_gh_url=https://github.com/ORG
export TF_VAR_gh_token=<GH_TOKEN>

terraform init
terraform plan
terraform apply -auto-approve
```
