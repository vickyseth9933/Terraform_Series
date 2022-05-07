# first thing while creating a AWS EC2 machine is to pick the AMI
# Terraform Docs for Ref. 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami#creation_date
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance


############
#Example 1 - Latest Linux AMI from Amazon

data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["amazon"]


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["al2022-ami-2022.0.20220204.0-kernel-5.10-x86_64"]
 }
}

output ami_id {
  value       = data.aws_ami.amazon-linux-2.creation_date
  #sensitive   = true
  description = "description"
  depends_on  = []
}

output ami_id_1 {
  value       = data.aws_ami.amazon-linux-2.id
  #sensitive   = true
  description = "description"
  depends_on  = []
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}

====

#another example to pick from random AWS account

data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["0187....3"]


 filter {
   name   = "name"
   values = ["03_07_2017_TJ"]
 }
}

output ami_id {
  value       = data.aws_ami.amazon-linux-2.id
  #sensitive   = true
  description = "description"
  depends_on  = []
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
