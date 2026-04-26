# Baraa - Azure IaC Terraform Lab

# Terraform Infrastructure as Code Lab

This is a small Terraform lab I made to practice Infrastructure as Code (IaC) on Azure.

The idea is simple: create a small network with two Linux virtual machines.
One VM is public and used as a jumpbox. The second VM is private and runs nginx.

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



## What it creates

- Resource group
- Virtual network
- Public subnet
- Private subnet
- Jumpbox VM with a public IP
- Web VM without a public IP
- Network security groups
- Nginx installed on the private VM

## Project layout

```text
.
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── modules
│   ├── network
│   ├── security
│   └── compute
└── scripts
    └── install-nginx.sh
