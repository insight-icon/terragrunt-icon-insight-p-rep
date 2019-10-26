# DNS

# Public Zones

- insight-icon.net 

# Private Zones 

- route 53 
    - icon.internal 
    - *.consul 
- consul
    - *.consul 
    - *.service.consul 
        - A
            - prep.service.consul:9000/v1/api/peers 
        - SRV
            - prep.service.consul/v1/api/peers 

- fqdn 
    - prep.us-east-1.dev.icon.internal 
    - **prep.service.consul**
 