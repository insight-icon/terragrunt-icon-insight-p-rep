# AWS Deployment 

Directory:

- `single-p-rep-single-citizen` 
    - **active development**
    - IaC for single P-Rep and single Citizen nodes
    - Single account - currently developing cross account security roles 
- `single-p-rep-multiple-citizen`
    - inactive
- `multiple-p-rep-multiple-citizen`
    - inactive
- `organization`
    - A one time deployment for a multi-account strategy deployment 
    - Sets up organization and sub accounts
- `modules` - **hidden until cloned**
    - Directory managed by `git-attributes` and pulled in with `git meta clone .` from root directory. 
    - Directory holds all the modules used by the deployment 
    - Production deployment uses pinned versions of modules pulled in dynamically 
