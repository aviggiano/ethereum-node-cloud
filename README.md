# ethereum-node-cloud

Terraform scripts to run an Ethereum node on the cloud

## Setup

### Hetzner

1. Create a project
2. [Generate an API key](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token/) and add it to `terraform.tfvars`
3. [Add a SSH key](https://community.hetzner.com/tutorials/add-ssh-key-to-your-hetzner-cloud)
4. Build and launch the instance

```bash
cd hetzner
packer init
packer build .
terraform init
terraform apply
```

### AWS

TODO

## References

- https://pawelurbanek.com/ethereum-node-aws
- https://community.hetzner.com/tutorials/custom-os-images-with-packer