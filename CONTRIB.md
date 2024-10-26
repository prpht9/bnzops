
# BNZOps Contrib Resources

This directory contains the components necessary to build your own fully functional solution bor a BNZOps implementation.  Each directory here should hold examples of sammple strategies you can use based on your needs.  Official strategies will be prefixed with bnz.

The benefits we focus on are things like:

* ensuring your startup single k8s node is already configured for multi-az deployment inside a network capable of conforming to a hub and spoke design, which you don't technically "need" for a few years. But adding network spokes is already part of how networks are deployed and how firewall rules and routes are configured. Even when you just got your first load balancer, app and db up and running.
* ensuring the location of your resources in your network complies with the most common compliance hurdles: PCI, HIPAA, SOC2, etc.
* ensuring role based accesss control (RBAC) for separation of duties is already in place when your businesss grows and the individuals filling those roles becomes more complex.

Our next feature is the inclusion of a community ranking system for deployment strategies. We will include our recommended strategies. But we will also allow our community to publish their own strategies. Then we will allow ranking of the strategies based on whether they are intended for startup, small, medium and enterprise size implementations.

See the [Overview](doc/bnzops_overview.md) page for more in depth explanation

# Table of Contents

1. [Terraform](#terraform)
2. [Usage](#usage)
3. [Documentation](#documentation)
4. [Support](#support)
5. [Contributing](#contributing)

## Terraform

Just clone the repo to your local workstation and work from the root dir of the project. This will change down the road.

## Usage

To start using bnzops you must have a strategy.yml file. This can be created using our `bin/configure` script or you can adjust an existing file manually. The script will prompt you to answer some questions and then will write a file locally for use by bnzops.

### Step One: Build Your Strategy

The idea here is to build your selected strategy into usable configuration files.  These then get used as input for the terraform for building out your environment.

### Step Two: Configure Terragrunt

Push your configurations to Terragrunt.  A sample terragrunt project with a usable layout for injecting the configurations is available in the example directory.

### Step Three: Configure Secrets

Configure your secret strategy.  This allows the system to authenticate and properly execute the workflows. Default secret strategy uses gnu pass for workstation use and vault from hashicorp for shared and system level secrets.

### Step Four: Start Initial Dependencies

* Network
* Custom Roles
* IAM Service Accounts
* Bastion Hosts
* Network Appliances
* k8s admin cluster
* k8s app cluster

## Documenation

* [Overview](doc/bnzops_overview.md)

## Support

We will only be using the GitHub Issues page for tracking issues. No "actual" support is possible at this point, the project is too small.

## Contributing

In order to attain very high velocity of this project. We will be using Ruby as our initial proof of concept language. We will not consider rewriting it in any other language until such time as we can justify such a change. An example where we could see this happening is if we decide to write an operator for k8s. This would of course be written in Go.

This is very early on in the project. Let's just use GitHub's pull request process for now. Fork this project, create a branch with your fix and submit a PR.

