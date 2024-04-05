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
journalctl -f -u geth
journalctl -f -u lighthouse
```

## Known issues

### Gateway Time-out when adding ppa:ethereum/ethereum

```txt
++ sudo add-apt-repository ppa:ethereum/ethereum
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      635/sshd: /usr/sbin
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      369/systemd-resolve
tcp6       0      0 :::22                   :::*                    LISTEN      635/sshd: /usr/sbin
Repository: 'deb https://ppa.launchpadcontent.net/ethereum/ethereum/ubuntu/ jammy main'
More info: https://launchpad.net/~ethereum/+archive/ubuntu/ethereum
Adding repository.
Adding deb entry to /etc/apt/sources.list.d/ethereum-ubuntu-ethereum-jammy.list
Adding disabled deb-src entry to /etc/apt/sources.list.d/ethereum-ubuntu-ethereum-jammy.list
Traceback (most recent call last):
  File "/usr/bin/add-apt-repository", line 364, in <module>
    sys.exit(0 if addaptrepo.main() else 1)
  File "/usr/bin/add-apt-repository", line 357, in main
    shortcut.add()
  File "/usr/lib/python3/dist-packages/softwareproperties/shortcuthandler.py", line 222, in add
    self.add_key()
  File "/usr/lib/python3/dist-packages/softwareproperties/shortcuthandler.py", line 398, in add_key
    if not all((self.trustedparts_file, self.trustedparts_content)):
  File "/usr/lib/python3/dist-packages/softwareproperties/ppa.py", line 141, in trustedparts_content
    key = self.lpppa.getSigningKeyData()
  File "/usr/lib/python3/dist-packages/lazr/restfulclient/resource.py", line 592, in __call__
    response, content = self.root._browser._request(
  File "/usr/lib/python3/dist-packages/lazr/restfulclient/_browser.py", line 429, in _request
    raise error
lazr.restfulclient.errors.ServerError: HTTP Error 504: Gateway Time-out
Response headers:
---
-content-encoding: gzip
cache-control: no-cache
content-length: 92
content-type: text/html
date: Fri, 05 Apr 2024 19:35:41 GMT
server: Apache/2.4.41 (Ubuntu)
status: 504
vary: Accept-Encoding
---
Response body:
---
b"<html><body><h1>504 Gateway Time-out</h1>\nThe server didn't respond in time.\n</body></html>\n"
---
```

Mitigation: try again

## References

- https://pawelurbanek.com/ethereum-node-aws
- https://community.hetzner.com/tutorials/custom-os-images-with-packer