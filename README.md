# Baraa - Azure IaC Terraform Lab

A small Infrastructure as Code project that builds a secure Azure IaaS
environment using Terraform and the AzureRM provider.


## What this builds

```
                       Internet
                          |
                 (your IP only, port 22)
                          |
                          v
        +---------- Resource Group -----------+
        |                                     |
        |   +----------- VNet --------------+ |
        |   |  10.20.0.0/16                 | |
        |   |                               | |
        |   |  Public subnet 10.20.1.0/24   | |
        |   |  +-------------------------+  | |
        |   |  | jumpbox VM   (Ubuntu)   |  | |
        |   |  | public IP attached      |  | |
        |   |  +-----------+-------------+  | |
        |   |              |                | |
        |   |              | SSH only       | |
        |   |              v                | |
        |   |  Private subnet 10.20.2.0/24  | |
        |   |  +-------------------------+  | |
        |   |  | web VM       (Ubuntu)   |  | |
        |   |  | nginx on :80, no public |  | |
        |   |  +-------------------------+  | |
        |   +-------------------------------+ |
        +-------------------------------------+
```

- One resource group
- One VNet, one public subnet, one private subnet
- One Linux jumpbox VM in the public subnet, with a public IP
- One Linux web VM in the private subnet, no public IP
- Two NSGs - public allows SSH only from your IP, private allows SSH only
  from the public subnet and HTTP only from inside the VNet
- Nginx is installed automatically on the web VM via cloud-init

## Folder structure

```
Terraform/
├── .gitignore
├── README.md
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars.example
├── variables.tf
├── modules/
│   ├── compute/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── network/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── security/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── scripts/
    └── install-nginx.sh
```

## Requirements

- Terraform >= 1.6
- Azure CLI
- An active Azure subscription
- An SSH key pair (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)

If you don't have an SSH key yet:

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
```

Log in to Azure:

```bash
az login
az account set --subscription "<your-subscription-id-or-name>"
```

## Setup

1. Copy the example variables file:

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Find your public IP and put it in `terraform.tfvars`:

   ```bash
   curl ifconfig.me
   ```

   Then edit the file:

   ```hcl
   allowed_ssh_cidr = "198.51.100.25/32"
   ```

   The `/32` means only that exact IP can reach SSH on the jumpbox.

## Run

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

When apply finishes you'll see the jumpbox public IP and the web VM
private IP printed as outputs.

## Access

Connect to the jumpbox:

```bash
ssh azureuser@<jumpbox-public-ip>
```

From inside the jumpbox, reach the web VM:

```bash
ssh azureuser@<web-private-ip>
```

Test nginx from the jumpbox without SSH-ing into the web VM:

```bash
curl http://<web-private-ip>
```

You should see the small "It works!" page.

## Cleanup

```bash
terraform destroy
```

Confirm with `yes`. This removes everything so you don't keep paying for
unused resources.

## Troubleshooting

**`terraform apply` hangs creating the web VM**
Cloud-init is still running. The VM finishes provisioning before nginx
is installed. Wait a minute, then `curl` it.

**`ssh: connection refused` on the jumpbox**
Check that `allowed_ssh_cidr` in `terraform.tfvars` actually matches
your current public IP - it changes if your ISP rotates it or you switch
networks. Re-run `terraform apply` after updating it.

**`Permission denied (publickey)` on either VM**
Confirm the path in `ssh_public_key_path` points to a public key that
matches the private key your SSH client is using. Use `ssh -i` to be
explicit if needed.

**Nginx page does not load**
SSH into the web VM through the jumpbox and check:

```bash
sudo systemctl status nginx
sudo tail -n 50 /var/log/cloud-init-output.log
```

## Security notes

- SSH from the internet is restricted to a single IP via the public NSG.
- The web VM has no public IP - it can only be reached through the
  jumpbox or from inside the VNet.
- Password login is disabled on both VMs - SSH keys only.
- An explicit deny-all rule sits at priority 4096 on both NSGs to make
  the intent obvious.

## Things not committed

The `.gitignore` blocks state files, `.tfvars`, plan files, and SSH
keys. Never push:

- `terraform.tfstate*`
- `terraform.tfvars`
- `*.pem`, `*.key`

The `.terraform.lock.hcl` file is **not** ignored on purpose - that one
should be committed so everyone uses the same provider versions.
