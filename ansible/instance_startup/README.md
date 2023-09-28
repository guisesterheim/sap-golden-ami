# Instance Startup

Code covering:
- Tuned (sap-hana for HANA and sap-netweaver for Netweaver)
- EFS mount

TEMP:

aws s3 rm s3://itsre-predev-bell-ec2-image-builder/ec2-image-builder/components/OEL/files/ansible.zip
rm -rf ansible.zip
zip -r ansible.zip ansible/*
aws s3 cp ansible.zip s3://itsre-predev-bell-ec2-image-builder/ec2-image-builder/components/OEL/files/ansible.zip

## Examples how to use
```
ansible_playbook_folder="/home/ec2-user/sap-golden-ami"
sudo ansible-playbook $ansible_playbook_folder/ansible/instance_startup/instance_startup.yaml \
    --extra-vars "INPUT_AWS_REGION=ca-central-1 INPUT_OS_CONFIG_TYPE=HANA GLOBAL_EFS_ACCESS_POINT_ID=fsap-0c1d2bf56becd5232 INPUT_EFS_ID=fs-0d441fde456d83ac0"
```

## Parameters
| Parameter | Sample value | Supported values | How it works |
| -- | -- | -- | -- |
| INPUT_ENVIRONMENT | dev | predev - dev - qa - prod | Affects user creation: which users to create in which instances | 
| INPUT_AWS_REGION | ca-central-1 | N/A | Used for mounting EFS |
| INPUT_OS_CONFIG_TYPE | HANA - ORACLE - NETWEAVER | Affects: EBS mount, directories creation, and SAP tuned configuration |
| INPUT_OS_TYPE | RHEL8.8 | OEL8.8 - RHEL 8.8 | SAP tuned configuration
| INPUT_EFS_ID | fs-0965f2540a0fb8fe7 | N/A | Sets which EFS to mount in this instance
| INPUT_EFS_ACCESS_POINT_ID | fsap-07260d66e9068e024 | N/A | Sets which EFS Mount Point to mount in this instance
| INPUT_HOSTNAME | sap-s77app01 | N/A | Hostname to be configured in this instance

## Userdata

ansible_playbook_folder="/home/ec2-user/sap-golden-ami"
rm -rf $ansible_playbook_folder

sudo yum install -y git ansible
git clone https://github.com/guisesterheim/sap-golden-ami.git $ansible_playbook_folder

sudo ansible-playbook /home/ec2-user/sap-golden-ami/ansible/instance_startup/instance_startup.yaml     --extra-vars "INPUT_AWS_REGION=ca-central-1 INPUT_OS_CONFIG_TYPE=NETWEAVER INPUT_OS_TYPE=OEL8.7 INPUT_EFS_ACCESS_POINT_ID=fsap-07260d66e9068e024 INPUT_EFS_ID=fs-0965f2540a0fb8fe7 INPUT_HOSTNAME=sap-s77app01 INPUT_ENVIRONMENT=pdev"