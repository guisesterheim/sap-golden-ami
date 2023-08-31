# sap-golden-ami
Ansible code for SAP Golden AMI build - RedHat and OEL

Code covering:
- Installing packages
- Installing AWS SAP data provider
- Installing SSM
- Installing AWS CLI
- Setting timezone
- Setting /etc/sysctl.d/sap.conf
- Set UUIDD


## Userdata

ansible_playbook_folder="/home/ec2-user/sap-golden-ami"
sudo yum install -y git ansible
git clone https://github.com/guisesterheim/sap-golden-ami.git $ansible_playbook_folder
sudo ansible-playbook $ansible_playbook_folder/ansible/bootstrap_instance.yaml