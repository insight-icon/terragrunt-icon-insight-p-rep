# Configuration

## Node Types

### EC2

- P-Rep 
- Citizen 

### ASG
 
- Citizen 
- Bastion 
- Sentry 
- Consul 
- Vault 

## Steps

### Packer + Ansible 

- Hardening 
- Consul agent 
- Monitoring agent 
- Logging agent 
- Load application 

### Cloud Init 

- Persist environment variables 
- Mount EBS volume 

#### ASG 

- Start consul 
- Start prometheus 
- Start fluentd exporter 
- Validation tests 
- Start application 
- Integration tests 

### Ansible 

- Validation tests 
- Start application 
- Integration tests 

## Repos 

### Ansible Roles 

- [p-rep-pack](https://github.com/insight-infrastructure/p-rep-pack)
- [citizen-pack](https://github.com/insight-infrastructure/citizen-pack)
- [sentry-pack](https://github.com/insight-infrastructure/sentry-pack)
- [bastion-pack](https://github.com/insight-infrastructure/bastion-pack)


