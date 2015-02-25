return unless platform?("ubuntu")

unless node["chef-devstax"]["apache"]["php"]["vhosts"]
	Chef::Application.fatal! "devstax.apache.php.vhosts attribute cannot be nil. Please populate that attribute."
end

include_recipe "apache2"

# create vhosts
node["chef-devstax"]["apache"]["php"]["vhosts"].each do |vhost|

	vhost_name = vhost["name"]
	vhost_docroot = "#{node['apache']['docroot_dir']}/#{vhost_name}"
	
	web_app vhost_name do
		template 'php_web_app.conf.erb'
		server_name vhost_name
		docroot vhost_docroot
	end

	directory vhost_docroot do
		action :create
		recursive true
	end

	file "#{vhost_docroot}/phpinfo.php" do
	  content "<?php phpinfo(); ?>"
	  only_if { vhost["phpinfo"] }
	end
	
end