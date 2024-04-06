# ethereum-node-cloud

Terraform scripts to run an Ethereum node on the cloud

## Setup

```bash
cd [ hetzner | aws ]
packer init
packer build .
terraform init
terraform apply
```

### AWS

1. [Create a SSH key](https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html)

### Hetzner

1. Create a project
2. [Generate an API key](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token/) and add it to `terraform.tfvars`
3. [Add a SSH key](https://community.hetzner.com/tutorials/add-ssh-key-to-your-hetzner-cloud)

## Usage

```bash
# Logs
journalctl -f -u reth
journalctl -f -u lighthouse
```

## References

- https://pawelurbanek.com/ethereum-node-aws
- https://community.hetzner.com/tutorials/custom-os-images-with-packer
