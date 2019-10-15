# Networking Map 


## VPCs

The network is divided within 4 tiers. 
- Main
    - Public Subnet
        - NLB 
    - Private Subnet
        - DDoS Sentry Layer 
    - Database 
        - Validator nodes 
        - Citizen nodes 
- Support 
    - Monitoring 
    - Logging 
    - Test bench 
- Support 
    - DNS 
    - Secrets management 
    - More to come 
- Management 
    - Bastion host 
    
Each subnet is broken down as per the table below.  All subnet ranges assume 3 
availability zones. To note, each range is further broken down to 
have a redundant subnet and room for a failover. 

| VPC | CIDR | Subnets | Public | Private |	Backend |
|----------|----------|----------|----------|----------||----------|
| main | 10.0.0.0/16 | 9 | 10.0.192.0/24 | 10.0.0.0/20 | 10.0.224.0/24 |
| services | 172.16.0.0/16 | 9 | 172.16.0.0/21 | 172.16.64.0/21 | 172.16.128.0/21 | 
| support	| 172.24.0.0/16	| 9 | 172.24.0.0/24 | 172.24.100.0/24 | 172.24.200.0/24 | 
| mgmt | 172.28.0.0/16 | 6 | 172.28.0.0/24 | 172.28.100.0/24 |	 |


### Main Vpc 

```hcl
  cidr = "10.0.0.0/16"

  public_subnets = [
    "10.0.192.0/24",
    "10.0.193.0/24",
    "10.0.194.0/24"]
    
  private_subnets = [
    "10.0.0.0/20",
    "10.0.16.0/20",
    "10.0.32.0/20"]
  
  database_subnets = [
    "10.0.224.0/24",
    "10.0.225.0/24",
    "10.0.226.0/24"]
```

### Services VPC 

```hcl
  cidr = "172.16.0.0/16"

  public_subnets = [
    "172.16.0.0/21",
    "172.16.8.0/21",
    "172.16.16.0/21"]

  private_subnets = [
    "172.16.64.0/21",
    "172.16.72.0/21",
    "172.16.80.0/21"]
```

### Support 

```hcl
  cidr = "172.24.0.0/16"

  public_subnets = [
    "172.24.0.0/24",
    "172.24.1.0/24",
    "172.24.2.0/24"]

  private_subnets = [
    "172.24.100.0/24",
    "172.24.101.0/24",
    "172.24.102.0/24"]
    
  database_subnets = [
    "172.24.200.0/24",
    "172.24.201.0/24",
    "172.24.202.0/24"]
```

### Management VPC 

```hcl
  cidr = "172.28.0.0/16"

  public_subnets = [
    "172.28.0.0/24",
    "172.28.1.0/24",
    "172.28.2.0/24"]
    
  private_subnets = [
    "172.28.100.0/24",
    "172.28.101.0/24",
    "172.28.102.0/24"]
    
  database_subnets = [
    "172.28.200.0/24",
    "172.28.201.0/24",
    "172.28.202.0/24"]
``` 
