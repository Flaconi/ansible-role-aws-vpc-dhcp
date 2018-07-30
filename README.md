# Ansible role: AWS VPC DHCP Options Set

This role is able to create any number of DHCP Options Sets, each attached to a VPC in AWS.

[![Build Status](https://travis-ci.org/Flaconi/ansible-role-aws-vpc-dhcp.svg?branch=master)](https://travis-ci.org/Flaconi/ansible-role-aws-vpc-dhcp)
[![Version](https://img.shields.io/github/tag/Flaconi/ansible-role-aws-vpc-dhcp.svg)](https://github.com/Flaconi/ansible-role-aws-vpc-dhcp/tags)
[![Ansible Galaxy](https://img.shields.io/ansible/role/d/25920.svg)](https://galaxy.ansible.com/Flaconi/aws-vpc-dhcp/)

## Requirements

* Ansible 2.5


## Additional variables

Additional variables that can be used (either as `host_vars`/`group_vars` or via command line args):

| Variable                            | Description                  |
|-------------------------------------|------------------------------|
| `aws_vpc_dhcp_profile`               | Boto profile name to be used |
| `aws_vpc_dhcp_default_region`        | Default region to use        |
| `aws_vpc_dhcp_vpc_filter_additional` | Additional `key` `val` filter to add to `vpc_filter` and `vpc_name` by default. |


## Example definition

DCHP Options Sets can be created per VPC either by supplying a VPC `name` or a
VPC `filter`.

#### Required parameter only

```yml
aws_vpc_dhcp_options_sets:
  # Create DHCP Options Sets for VPCs by VPC name
  - name: my-dhcp-1
    vpc_name: devops-test-vpc
  # Create DHCP Options Sets for VPCs by VPC filter
  - name: my-dhcp-2
    vpc_filter:
      - key: "tag:Name"
        val: "devops-test-vpc"
      - key: "tag:env"
        val: playground
      - key: "tag:department"
        val: devops
```

#### All available parameters
```yml
# Ensure VPC filter (name or filter) includes a VPC in the "available" state
# (not pending nor deleted)
aws_vpc_dhcp_vpc_filter_additional:
  - key: state
    val: available

aws_vpc_dhcp_option_sets:
  # Create DHCP Options Sets for VPCs by VPC name
  - name: my-dhcp-1
    vpc_name: devops-test-vpc
    inherit_existing: True
    domain_name: some.domain other.domain
    dns_servers: AmazonProvidedDNS
    region: eu-central-1
    tags:
      - key: env
        val: playground
      - key: department
        val: devops
  # Create DHCP Options Sets for VPCs by VPC filter
  - name: my-dhcp-2
    domain_name: some.domain
    vpc_filter:
      - key: "tag:Name"
        val: "devops-test-vpc"
      - key: "tag:env"
        val: playground
      - key: "tag:department"
        val: devops
    region: eu-central-1
    tags:
      - key: env
        val: playground
      - key: department
        val: devops
```


## Testing

#### Requirements

* Docker
* [yamllint](https://github.com/adrienverge/yamllint)

#### Run tests

```bash
# Lint the source files
make lint

# Run integration tests with default Ansible version
make test

# Run integration tests with custom Ansible version
make test ANSIBLE_VERSION=2.4
```
