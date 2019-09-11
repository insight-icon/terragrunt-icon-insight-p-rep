region = "us-east-1"
cidr = "10.0.0.0/16"
azs = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c"]
// Running P-Rep in 1b - smaller subnet with one bastion
private_subnets = [
  "10.0.0.0/24",
  "10.0.1.0/28",
  "10.0.2.0/24"]
public_subnets = [
  "10.0.64.0/20",
  "10.0.80.0/20",
  "10.0.96.0/20"]
