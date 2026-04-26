# Terraform Infrastructure as Code Lab

This is a small project I made to practice Infrastructure as Code (IaC) using Terraform on Azure.

The idea was to build a simple setup with two Linux virtual machines and understand how networking and security work between them.

## What this project does

It creates:

- A resource group
- A virtual network
- One public subnet
- One private subnet
- A jumpbox VM with a public IP
- A web VM without a public IP
- Network security rules
- Nginx installed on the private VM

The private VM is not exposed to the internet.  
Access is done through the jumpbox.

## Why I built this

I wanted to get more comfortable with Terraform and understand how infrastructure is defined using code.

At the beginning I was just creating simple resources, but I wanted something a bit more realistic, especially with networking and access control.

## What I learned

- How to use Terraform modules
- How virtual networks and subnets work
- Basic Network Security Group rules
- How to connect to a private VM using a jumpbox
- How to run a simple script on a VM (nginx install)

## What I struggled with

At first I had problems connecting to the private VM.

SSH was not working and I did not understand why.

After checking the setup, I realized the issue was with the NSG rules and how the subnets were configured.

It took some time to figure it out, but it helped me understand the networking part better.

## Project structure

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
