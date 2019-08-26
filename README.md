# terragrunt-icon-insight-p-rep

**WARNING** : This is very much a work in progress.  Please contact me via telegram or the ICON forum for any input. 

[Link to ICON Forum thread covering this work.](https://forum.icon.community/t/automated-terraform-deployments/113)

## Current state 

- Running multiple environments (prod, stage, dev) each tied to their own respective accounts 
    - Moving this to a multi-account security strategy with all IAM roles stored in a single account
- `aws/single-p-rep-single-citizen/dev` where current work is taking place
- Nodes are starting but need configuration via SSH 
    - Assuming P-Rep nodes will be manual for now with governance policies dictating key handling 


## TTD 

Near term (Early September): 

- S3 static website deployment 
- Simple cloudwatch logging 
- Segregate IAM roles into separate account 
- Ansible configuration steps 

Longer term:
- Alarms 
- Failover 
- Supporting services 


### Child Modules 

To pull in a local copy of associated modules, install `meta` - `npm i -g meta`. Then run `meta git clone .` and the 
modules will show up in associated cloud folder. 

- [terraform-aws-icon-p-rep-node](https://github.com/robc-io/terraform-aws-icon-p-rep-node)
- [terraform-aws-icon-p-rep-sg](https://github.com/robc-io/terraform-aws-icon-p-rep-sg)
- [terraform-aws-icon-p-rep-keys](https://github.com/robc-io/terraform-aws-icon-p-rep-keys)
- [terraform-aws-icon-citizen-node](https://github.com/robc-io/terraform-aws-icon-citizen-node)
- [terraform-aws-cloudfront-s3-acm](https://github.com/robc-io/terraform-aws-cloudfront-s3-acm)


### Workflow 

The workflow to edit modules is to import them with `meta git clone .`, change the source in the module level 
`terragrunt.hcl` to point directly to the module like below and run `terragrunt apply`. Normal nuances of terraform 
apply. 

```
terraform {
//  source = "github.com/robcxyz/terraform-aws-icon-p-rep-node.git?ref=0.0.1"
//  source = "github.com/robcxyz/terraform-aws-icon-p-rep-node.git"
  source = "../../../../../modules/terraform-aws-icon-p-rep-node"
}
```

The idea is that you can make changes in `dev` locally not worrying if you break things, then you promote changes up to 
`stage` (a mirror of `prod`), then on to `prod`. More on this later. 


