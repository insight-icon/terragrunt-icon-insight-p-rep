# Bootstrapping


## Bootstrapping Methods 

### user-data / cloud-init

- Insecure for any secrets 

### terraform provisioner 

- Works based on ssh 
- Need key in `.ssh`
- Called in line with terraform 
- Need private 

### Ansible 

- Secure 
- Much better for using with bastion 
- Secrets are fine 
    - Vault 

## Bootstrapping Logistics 

### Bastion Host 

### Key Management 

