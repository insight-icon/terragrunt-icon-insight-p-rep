# Folder Structure Design

The file structure of this project is a highly opinionated design that needs a little discussion to understand why it is laid out this way

- Minimize the amount of terraform `outputs` blocks to pipe data in and out of modules
    - Every time you build a module, to reference it's outputs you need to explicitly declare them 
    - This leads to a lot of WET (write everything twice) code as you nest modules inside modules 
    - To overcome this, we lean heavily towards calling the modules directly from terragrunt and piping data in through the terragrunt config in `dependency` blocks

- Group together components by function 
    - Networking 
    - Applications 

### Folder Hierarchy 

```
└── environment
    ├── account.tfvars
    ├── environment.tfvars
    ├── region
    │   ├── group
    │   │   ├── group.tfvars
    │   │   └── module
    │   │       ├── aws_provider.tf
    │   │       ├── aws_variables.tf
    │   │       ├── submodule
    │   │       │   ├── aws_provider.tf
    │   │       │   ├── aws_variables.tf
    │   │       │   └── terragrunt.hcl
    │   │       └── terragrunt.hcl
    │   └── region.tfvars
    └── terragrunt.hcl
```