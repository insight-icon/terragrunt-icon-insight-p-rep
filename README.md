# terragrunt-icon-insight-p-rep

**Work in progress** - Please get in touch 

[Link to ICON Forum thread covering this work.](https://forum.icon.community/t/automated-terraform-deployments/113)

## Current state 

- Focused on `single-p-rep-single-citizen` deployment until sentry layer is done 
- Running multiple environments (prod, stage, dev) each tied to their own respective accounts 
    - Moving this to a multi-account security strategy with all IAM roles stored in a single account
- Building centralized logging and monitoring 
    - Insight project seed will cover these two areas separately
- Building identity account 
    - Already assigned project to Justin Grosvner 
    - Building vault cluster and web ui login to gain access to your identity / each services identity that can then be 
    assumed to make all the changes in the accounts / authenticate with various DApps

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
- [terraform-aws-cloudfront-s3-acm-root](https://github.com/robc-io/terraform-aws-cloudfront-s3-acm-root)
- [terraform-aws-icon-lambda-whitelist-cron](https://github.com/robc-io/terraform-aws-icon-lambda-whitelist-cron)


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


