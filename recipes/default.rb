#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# # imports
# include_recipe 'sc-mongodb::default'
# include_recipe 'apt'
# include_recipe 'yum'
# include_recipe 'build-essential'
#
# apt_update
#
# package 'mongodb'
#
# cookbook_file '/etc/apt/sources.list' do
#   source 'sources.list'
#   notifies :update, "apt_update[all platforms]"
# end
#
# apt_update 'all platforms' do
#   action :nothing
# end
#
# service 'enable mongodb' do
#   action :enable
# end

bash 'install mongodb' do
  user 'root'
  code <<-EOH
    wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
    sudo systemctl restart mongod
    sudo systemctl enable mongod
    EOH
end
