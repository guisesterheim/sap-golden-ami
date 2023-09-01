# sap-golden-ami
Ansible code for SAP Golden AMI build - RedHat and OEL

Code covering:
- Installing packages
- Installing AWS SAP data provider
- Installing SSM
- Installing AWS CLI
- Enable NFS
- Set clocksource
- Setting /etc/sysctl.d/sap.conf
- Setting timezone
- Set tuned
- Set UUIDD


while updating tuned. There's two profiles: sap-hana and sap-netweaver. Do we need two different images because of that? Or do we prefer one of them over the other?


## Userdata

ansible_playbook_folder="/home/ec2-user/sap-golden-ami"
rm -rf $ansible_playbook_folder

sudo yum install -y git ansible
git clone https://github.com/guisesterheim/sap-golden-ami.git $ansible_playbook_folder
sudo ansible-playbook $ansible_playbook_folder/ansible/golden_amis/bootstrap_instance.yaml