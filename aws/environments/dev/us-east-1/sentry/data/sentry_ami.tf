data "aws_caller_identity" "current"{
}

//data "aws_ami" "ubuntu_sentry" {
//  count = ""
//
//  most_recent = true
//
//  tags = {
//    Name   = "icon-sentry"
//    Distro = "Ubuntu-18"
//  }
//
//  owners = [data.aws_caller_identity.current.account_id]
//}
//
//output "ubuntu_ami_id" {
//  value = data.aws_ami.ubuntu_sentry.id
//}


data "aws_ami" "debian_sentry_ami" {
  most_recent = true

  tags = {
    Name   = "icon-sentry"
    Distro = "Debian-9"
  }

//  owners = [data.aws_caller_identity.current.account_id]
  owners = ["self"]
}

output "debian_ami_id" {
  value = data.aws_ami.debian_sentry_ami.id
}
