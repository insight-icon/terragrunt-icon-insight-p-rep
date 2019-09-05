# terragrunt-icon-insight-p-rep

**Work in progress** - Please get in touch 

[Link to ICON Forum thread covering this work.](https://forum.icon.community/t/automated-terraform-deployments/113)

## To Use 

1. Export AWS keys to environment variables or profile 
2. Install terraform and terragrunt. Best way is with [tfswitch](https://github.com/warrensbox/terraform-switcher) and [tgswitch](https://github.com/warrensbox/tgswitch)

**For Development** 

3. Install `meta` - `npm i -g meta` 
4. Run `meta git clone .` from the root to clone modules locally 
5. If you find things that need work, when you `cd` into the module directory you are now in a separate repo

**For Deployment** 

6. Do this:

```
cd aws/single-p-rep-single-citizen/prod/
chmod +x ./helpers/init.sh 
./helpers/init.sh <ACCOUNT_ID> us-east-1 <LOCAL_KEY_FILE path> 
cd us-east-1/network
terragrunt apply-all --terragrunt-source-update
cd ../p-rep
terragrunt apply-all --terragrunt-source-update
```

This will be simplified but basically we need sensitive information like account_id 

7. You can now ssh into the box and get it going.  The `data` EBS volume that has 
8. To destroy replace `terragrunt apply-all` with `terragrunt destroy-all`
9. Make modifications
10. Repeat

## Current state 

- Focused on `single-p-rep-single-citizen` deployment until sentry layer is done 
- Still need to update `user-data` so that it bootstraps properly - had it working in last testnet just need to copy over
- Ripping out any IAM and putting it in global directory next to region - ie us-east-1
- Spot instance autoscaling group for sentry layer 
- Fix lambda security group update process - assigned to [iBriz.ai](http://ibriz.ai/)   
- Running multiple environments (prod, stage, dev) each tied to their own respective accounts 
- 8 Insight fellow project seeds can be found [here](https://docs.insight-icon.net/index.html)
- Building centralized logging and monitoring 
    - Insight project seed will cover these two areas separately
    - [See proposals](https://docs.insight-icon.net/insight-icon-project-seeds/index-project-seeds.html)
- Building identity account 
    - Already assigned project to Justin Grosvner 
    - Building vault cluster and web ui login to gain access to applications 
 
 Basically a lot more replication and then filling in with proper features. Alarms and other enterprise security features
 will be more important when the basic stack is up and when we move to HA. 

## TTD 

Near term (Early September): 

- Simple cloudwatch logging 
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


