
# Bias Near Zero Ops

bnzops is a project intended to help teams deploy infrastructure and services in the cloud and on premise with as near to zero ops as we can get. The main concept is to make a few best practice strategies available for deployment to prevent anti-patterns and facilitate slight adjustment of the configurations to meet the unforseen needs of the consumers. We accomplish this by intentionally having bias towards a few specific solutions which facilitate the growth from small startup to enterprise solutions without having to change any of your initial ifrastructure design. Starting with a small deployment which already complies with the enterprise design makes it so you never have to redesign as you grow. This saves you from having to do re-work and re-design when all you want to do is scale. By "scale", we don't mean instance groups going from 2 to 10 instances across more availability zones. We don't mean changing database instance or volume sizes for more capacity.

The benefits we focus on are things like:

* ensuring your startup single k8s node is already configured for multi-az deployment inside a network capable of conforming to a hub and spoke design, which you don't technically "need" for a few years. But adding network spokes is already part of how networks are deployed and how firewall rules and routes are configured. Even when you just got your first load balancer, app and db up and running.
* ensuring the location of your resources in your network complies with the most common compliance hurdles: PCI, HIPAA, SOC2, etc.
* ensuring role based accesss control (RBAC) for separation of duties is already in place when your businesss grows and the individuals filling those roles becomes more complex.

Our next feature is the inclusion of a community ranking system for deployment strategies. We will include our recommended strategies. But we will also allow our community to publish their own strategies. Then we will allow ranking of the strategies based on whether they are intended for startup, small, medium and enterprise size implementations.

See the [Overview](doc/bnzops_overview) page for more in depth explanation

# Table of Contents

1. [Install](#install)
2. [Usage](#usage)
3. [Documentation](#documentation)
4. [Support](#support)
5. [Contributing](#contributing)

## Install

Just clone the repo to your local workstation and work from the root dir of the project. This will change down the road.

## Usage

To start using bnzops you must have a strategy.yml file. This can be created using our `bin/configure` script or you can adjust an existing file manually. The script will prompt you to answer some questions and then will write a file locally for use by bnzops.

## Documenation

* [Overview](doc/bnzops_overview)

## Support

We will only be using the GitHub Issues page for tracking issues. No "actual" support is possible at this point, the project is too small.

## Contributing

In order to attain very high velocity of this project. We will be using Ruby as our initial proof of concept language. We will not consider rewriting it in any other language until such time as we can justify such a change. An example where we could see this happening is if we decide to write an operator for k8s. This would of course be written in Go.

This is very early on in the project. Let's just use GitHub's pull request process for now. Fork this project, create a branch with your fix and submit a PR.

