return unless platform?("ubuntu")

unless node["chef-devstax"]["filevault"]["url"]
	Chef::Application.fatal! "chef-devstax.filevault.url attribute cannot be nil. Please populate that attribute."
end

include_recipe "apt"
include_recipe "java"

fvtgz = "#{Chef::Config[:file_cache_path]}/filevault.tgz"
remote_file fvtgz do
	source "#{node["chef-devstax"]["filevault"]["url"]}"
	action :create_if_missing
end
directory "/opt/aem/vault-cli" do
	action :create
	recursive true
end
bash 'install_filevault' do
	code <<-EOH
	tar -xzf #{fvtgz} -C /opt/aem/vault-cli --strip-components=1
	ln -s /opt/aem/vault-cli/bin/vlt /usr/bin/vlt
	EOH
end