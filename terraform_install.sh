# how to innstall terraform
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform


# install hashicorp
sudo yum -y install vault
vault server -dev
#Unseal Key: PLV0OXO9VmF5VB8qAnq4pQIGzWkzzYypRNcDtrhSSgU=
#Root Token: hvs.6j4cuewowBGit65rheNoceI7
export VAULT_ADDR='http://127.0.0.1:8200'
