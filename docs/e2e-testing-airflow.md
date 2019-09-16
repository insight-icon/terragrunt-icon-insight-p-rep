# E2E Testing 

## Airflow Startup Tasks 

- Spin up EKS 
- Set context to allow access to dashboard 
- Get helm running 
- Install airflow 
    - [helm chart](https://github.com/helm/charts/tree/master/stable/airflow)
- Install operator 
    - [Operator](https://github.com/GoogleCloudPlatform/airflow-operator)
- Login to airflow 
    - Just checking to see if have console
- Setup shared dag directory 
    - Options 
        - NFS - A+
            - Manage permissions 
            - Rook 
            - Persistent volume claims 
