# DevOps Assignment

Develop a repeatable process using tools or languages of your choice to deploy a micro application in the cloud.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Assignment time
```
Start Time - 23-March-2021 8:30 PM
End Time   - 23-March-2021 10:30 PM
```
### Prerequisites

What things you need to install the software and how to install them

```
Terraform
```

### Installing


```
Install terraform locally using - https://learn.hashicorp.com/tutorials/terraform/install-cli
```

### Configuration

Configure AWS user credentials in ~/.aws/credentials file
```
[terraform]
aws_access_key_id = xxxxxxxxxxxxx
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxx
```

### AWS Key Configuration
Create and download pem key from https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs

Name the key `ubuntu-user.pem`

Download key locally and place it under `~/ubuntu-user.pem` location


## Running Terraform deploy

Run below command to check what resources are going to be created
```
terraform plan
```
Run below command to deploy resources on AWS

```
terraform deploy --auto-approve
```

Destroy setup
```
terraform destroy --auto-approve
```

PS - If you want to just setup infrastructure without downloading keys from AWS, comment out `provisioner` and `connection` blocks in main.tf

## Thing to improve
The script has been put togather hastly and needs lot of refactoring and improvement.
* Add modules for Security Groups, Instances to reuse code
* Pass all the parameters via variables
* Better package module handling either using Packer or Ansible
* Store state file in S3 bucket
 