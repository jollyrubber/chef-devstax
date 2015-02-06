unless node["chef-devstax"]["apache"]["python"]["vhosts"]
	Chef::Application.fatal! "devstax.apache.python.vhosts attribute cannot be nil. Please populate that attribute."
end

include_recipe "apache2"

# create vhosts
node["chef-devstax"]["apache"]["python"]["vhosts"].each do |vhost|

	vhost_name = vhost["name"]
	vhost_docroot = "#{node['apache']['docroot_dir']}/#{vhost_name}"
	
	web_app vhost_name do
		template 'python_web_app.conf.erb'
		server_name vhost_name
		docroot vhost_docroot
	end
	
	directory vhost_docroot do
		action :create
		recursive true
	end
	
	template "#{vhost_docroot}/testpy.wsgi" do
		source "testpy.wsgi.erb"
		variables ({
			:site_name => vhost_name
		})
	end
	
end