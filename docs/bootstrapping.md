# Bootstrapping

## Bootstrapping Methods 

### General 

#### user-data / cloud-init

- Insecure for any secrets 

#### terraform provisioner 

- Works based on ssh 
- Need key in `.ssh`
- Called in line with terraform 
- Need private 

#### Ansible 

- Secure 
- Much better for using with bastion 
- Secrets are fine 
    - Vault 

### Kubernetes 

#### eks 

- Managed k8s 
- Simpler to run 
- Not cloud native as tied to AWS 

#### kops 

- Harder to run that EKS but cloud native 
- Use native k8s 

#### docker registry 


## Bootstrapping Logistics 

### Bastion Host 

### Key Management 

