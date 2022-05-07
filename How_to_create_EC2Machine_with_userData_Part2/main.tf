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



resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-linux-2.id
  #ami = ami-079b5e5b3971bd10d
  #ami = var.ami_id
  instance_type = var.instance_type
  key_name = "today-demo"
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to my-channel, please do subscribe my channel :-) us-east-1 Region</h1>" > /var/www/html/index.html
    EOF

  tags = {
    Name = "HelloWorld"
  }
}
