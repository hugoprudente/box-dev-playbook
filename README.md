# Cloud9++

An extra customized Cloud9 Box for DevOps and general study!

## Why?

* From: Everywhere
* With: Vim / Vim Support
* And: Any Device

## Deploy

This will create an VPC with *n* public, *n* private subnets with Cloud9.

```bash
$git clone https://github.com/hugoprudente/cloud9-plusplus.git
```

Configure the *REGION*, *NAME*, and *IAMUSER* on the **bin/deploy**, file to match your AWS configurations.

```
REGION=eu-west-1
NAME=cloud9pp
IAMUSER=$USER
```

Deploy it!

```
$bin/deploy
```

This creates [Public (IGW)/Private(NAT)](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html) subnets using all available AZs on give region and create a Cloud9 with extra volume and 2 CodeCommit repositories.

## Extra Setup

TODO, add ansible playbooks