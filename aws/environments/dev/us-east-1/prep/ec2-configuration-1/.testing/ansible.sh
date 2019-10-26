ANSIBLE_CONFIG=./ansible.cfg
ANSIBLE_SCP_IF_SSH=true
ANSIBLE_FORCE_COLOR=true
ANSIBLE_ROLES_PATH=/c/Users/rob/PycharmProjects/blockchain/icon/terragrunt-icon-insight-p-rep/aws/environments/dev/us-east-1/p-rep/ec2-configuration/p-rep-config/roles

ansible-playbook /c/Users/rob/PycharmProjects/blockchain/icon/terragrunt-icon-insight-p-rep/aws/environments/dev/us-east-1/p-rep/ec2-configuration/p-rep-config/configure.yml \
--inventory=10.0.8.58, \
--user=ubuntu \
--become-method=sudo \
--forks=5 \
--ssh-extra-args='-p 22 -o ConnectTimeout=10 -o ConnectionAttempts=10 -o StrictHostKeyChecking=no' \
--private-key=/c/Users/rob/.ssh/id_rsa
