# Instance Startup

Code covering:
- Tuned (sap-hana for HANA and sap-netweaver for Netweaver)
- EFS mount

## Examples how to use
```
ansible_playbook_folder="/home/ec2-user/sap-golden-ami"
sudo ansible-playbook $ansible_playbook_folder/ansible/instance_startup/instance_startup.yaml \
    --extra-vars "INPUT_AWS_REGION=ca-central-1 INPUT_APPLICATION_TYPE=HANA GLOBAL_EFS_ACCESS_POINT_ID=fsap-0c1d2bf56becd5232 INPUT_EFS_ID=fs-0d441fde456d83ac0"
```

## Userdata

ansible_playbook_folder="/home/ec2-user/sap-golden-ami"
rm -rf $ansible_playbook_folder

sudo yum install -y git ansible
git clone https://github.com/guisesterheim/sap-golden-ami.git $ansible_playbook_folder
sudo ansible-playbook $ansible_playbook_folder/ansible/instance_startup/instance_startup.yaml \
    --extra-vars "INPUT_AWS_REGION=ca-central-1 INPUT_APPLICATION_TYPE=HANA GLOBAL_EFS_ACCESS_POINT_ID=fsap-0c1d2bf56becd5232 INPUT_EFS_ID=fs-0d441fde456d83ac0 INPUT_HOSTNAME=hostname INPUT_ENVIRONMENT=pdev"
