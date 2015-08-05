# Install MySQL Client & Server

unless node["chef-devstax"]["mysql"]["version"]
    Chef::Application.fatal! "chef-devstax.mysql.version attribute cannot be nil. Please populate that attribute."
end

db_root_passwd = node["chef-devstax"]["mysql"]["rootpasswd"]
db_verison = node["chef-devstax"]["mysql"]["version"]

# install MySQL daemon & client
mysql_service :default do
    version db_verison
    initial_root_password db_root_passwd
    action [:create, :start]
end
mysql_client :default do
    version db_verison
    action :create
end
