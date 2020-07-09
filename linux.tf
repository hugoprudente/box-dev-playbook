terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = ">= 2.28.1"
  region  = "eu-west-1"
  shared_credentials_file = "/home/ec2-user/.aws/creds"
  profile                 = "hprudent"
}

variable "ami" {
  type = list
  default     = [
  { ami_id = "ami-06ce3edf0cff21f07", "name" = "Amazon Linux 2 AMI "},
  { ami_id = "ami-0b4b2d87bdd32212a", "name" = "Amazon Linux AMI 2018.03.0 "},
  { ami_id = "ami-08f4717d06813bf00", "name" = "Red Hat Enterprise Linux 8 (HVM)"},
  { ami_id = "ami-02ecd61acb94c136d", "name" = "SUSE Linux Enterprise Server 15 SP1 () "},
  { ami_id = "ami-0701e7be9b2a77600", "name" = "Ubuntu Server 18.04 LTS (HVM) "},
  { ami_id = "ami-0f2ed58082cb08a4d", "name" = "Ubuntu Server 16.04 LTS (HVM) "},
  # { ami_id = "ami-00a845a11b3d1f308", "name" = "Debian GNU/Linux 9 (Stretch) "},
  # { ami_id = "ami-3291be54", "name" = "Debian GNU/Linux 8 (Jessie) "},
  # { ami_id = "ami-0bf25010ee0439b82", "name" = "Kali Linux "},
  # { ami_id = "ami-0451e9d3427711cb1", "name" = "CentOS 6 (x86_64) - with Updates HVM "},
  # { ami_id = "ami-0ff760d16d9497662", "name" = "CentOS 7 (x86_64) - with Updates HVM "},
  # { ami_id = "ami-0fe1b3c541a7eed1c", "name" = "FreeBSD 12"},
  ]
}

resource "aws_instance" "allmightbox" {
  count = 6
  ami           = var.ami[count.index].ami_id
  instance_type = "t2.micro"
  subnet_id     = "subnet-01a4bebfd46e31515"
  key_name      = "hprudent"
  security_groups = ["sg-029886edab0f82f69"]
  tags = {
    Name = "Yoda ${var.ami[count.index].name}",
    auto-delete = "never"
  }
  user_data = file("userdata.sh")
  iam_instance_profile = "opsworks-cm-ec2-node-associate-role"
}

output "instance_ips" {
  value = ["${aws_instance.allmightbox.*.private_ip}"]
}
