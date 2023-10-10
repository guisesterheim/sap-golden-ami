# Manual tasks for creating the base AMI:

1. Create instance from the public AMI. Attach gp3 volume and encyprt using the kms_ebs key
2. Download SSM Agent and AWS CLI installer binaries, and push it to an S3 bucket
3. SSM on the jumpbox, move the binaries into your base instance
4. Configure proxy with:
```
#Set the proxy hostname and port
PROXY=fastweb.cac1.aws.int.bell.ca:80
MAC=$(curl -s http://169.254.169.254/latest/meta-data/mac/)
VPC_CIDR=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$MAC/vpc-ipv4-cidr-blocks | xargs | tr ' ' ',')

#[Option] Configure yum to use the proxy
cloud-init-per instance yum_proxy_config cat << EOF >> /etc/yum.conf
proxy=http://$PROXY
EOF

#Set the proxy for future processes, and use as an include file
cloud-init-per instance proxy_config cat << EOF >> /etc/environment
http_proxy=http://$PROXY
https_proxy=http://$PROXY
HTTP_PROXY=http://$PROXY
HTTPS_PROXY=http://$PROXY
no_proxy=$VPC_CIDR,localhost,127.0.0.1,169.254.169.254,.internal,.eks.amazonaws.com,eks.ca-central-1.amazonaws.com,api.ecr.ca-central-1.amazonaws.com,dkr.ecr.ca-central-1.amazonaws.com,ec2.ca-central-1.amazonaws.com,sts.ca-central-1.amazonaws.com,int.bell.ca,gitlab.int.bell.ca,ht-docker-prod.artifactory.int.bell.ca
NO_PROXY=$VPC_CIDR,localhost,127.0.0.1,169.254.169.254,.internal,.eks.amazonaws.com,eks.ca-central-1.amazonaws.com,api.ecr.ca-central-1.amazonaws.com,dkr.ecr.ca-central-1.amazonaws.com,ec2.ca-central-1.amazonaws.com,sts.ca-central-1.amazonaws.com,int.bell.ca,gitlab.int.bell.ca,ht-docker-prod.artifactory.int.bell.ca
EOF
```
5. Install unzip
6. Install SSM with ```rpm -i amazon-ssm-agent.rpm```
7. Install AWS CLI like shown here: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html




# Temporary commands to handle Ansible

rm -rf ansible.zip
zip -r ansible.zip ansible/*
aws s3 cp ansible.zip s3://itsre-predev-bell-ec2-image-builder/ec2-image-builder/components/OEL/files/ansible.zip



ansible_playbook_folder="/home/ec2-user/ansible"
rm -rf $ansible_playbook_folder

sudo yum install -y git ansible-core
aws s3 cp s3://itsre-predev-bell-ec2-image-builder/ec2-image-builder/components/OEL/files/ansible.zip /home/ec2-user/ansible.zip
unzip /home/ec2-user/ansible.zip

sudo ansible-playbook $ansible_playbook_folder/golden_amis/bootstrap_instance.yaml




ansible_playbook_folder="/home/ec2-user/ansible"
rm -rf $ansible_playbook_folder

aws s3 cp s3://itsre-predev-bell-ec2-image-builder/ec2-image-builder/components/OEL/files/ansible.zip /home/ec2-user/ansible.zip
unzip /home/ec2-user/ansible.zip

sudo ansible-playbook /home/ec2-user/ansible/instance_startup/instance_startup.yaml     --extra-vars "INPUT_AWS_REGION=ca-central-1 INPUT_OS_CONFIG_TYPE=ORACLE INPUT_OS_TYPE=OEL8.8 INPUT_HOSTNAME=ec2rc1sapdbl016 INPUT_HOSTNAME_FQDN=ec2rc1sapdbl016.itsre-sap-predev.cac1.aws.int.bell.ca INPUT_ENVIRONMENT=predev INPUT_REQUIRED_EFS_TO_MOUNT=\"sapmedia:
  efs_id: fs-02d0ad1da59cc2b80
  full_path: /sapmedia
  mount_target_ip: 10.78.120.12
sapmnt:
  efs_id: fs-0cd54cbf512ac2add
  full_path: /sapmnt
  mount_target_ip: 10.78.120.31
\" INPUT_EBS_MAP_TO_MOUNT=\"etc_tivoli:
  device_name: /dev/xvdl
  os_path_to_mount: /etc/Tivoli
opt_ibm_tws930:
  device_name: /dev/xvdn
  os_path_to_mount: /opt/IBM/tws930
oracle:
  device_name: /dev/xvdaa
  os_path_to_mount: /oracle
oracle2:
  device_name: /dev/xvdab
  os_path_to_mount: /oracle
sapcd:
  device_name: /dev/xvde
  os_path_to_mount: /SAPCD
swap:
  device_name: /dev/xvdo
  os_path_to_mount: swap
tmp:
  device_name: /dev/xvdb
  os_path_to_mount: /tmp
usr_sap:
  device_name: /dev/xvdc
  os_path_to_mount: /usr/sap
usr_sap_daa:
  device_name: /dev/xvdd
  os_path_to_mount: /usr/sap/DAA
usr_tivoli:
  device_name: /dev/xvdm
  os_path_to_mount: /usr/Tivoli
\""