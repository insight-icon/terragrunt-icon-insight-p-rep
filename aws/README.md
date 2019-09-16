# AWS Deployment 

Directory:

- `single-p-rep-single-citizen` 
    - **active development**
    - IaC for single P-Rep and single Citizen nodes
    - Single account - currently developing cross account security roles 
- `multiple-p-rep-multiple-citizen`
    - inactive
- `organization`
    - A one time deployment for a multi-account strategy deployment 
    - Sets up organization and sub accounts
- `modules` - **hidden until cloned**
    - Directory managed by `git-attributes` and pulled in with `git meta clone .` from root directory. 
    - Directory holds all the modules used by the deployment 
    - Production deployment uses pinned versions of modules pulled in dynamically 

### Why is everything organized this way?

Good question. 

- So this is sort of an interim design as we are narrowing down on different features.
- When the HA deployment is working and we have more optionality with configurations, we will move the 
configurations over to a common directory and only deploy what is different between the configurations within 
that directory. 
- Right now there is a lot of copy and paste but that is fine as we rush to get all the features integrated 
- Future we'll clean up and have a more clear layout, right now it is all stuffed in the `single` directory