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

