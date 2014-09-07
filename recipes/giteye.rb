unless node["chef-devstax"]["giteye"]["url"]
	Chef::Application.fatal! "chef-devstax.giteye.url attribute cannot be nil. Please populate that attribute."
end
unless node["chef-devstax"]["giteye"]["version"]
	Chef::Application.fatal! "chef-devstax.giteye.version attribute cannot be nil. Please populate that attribute."
end

include_recipe "java"
include_recipe "ark"
include_recipe "chef-devstax::eclipse_prereqs"

giteye_url = node["chef-devstax"]["giteye"]["url"]
giteye_version = node["chef-devstax"]["giteye"]["version"]

ark "giteye" do
  url giteye_url
  version giteye_version
  extension "zip"
  has_binaries ['GitEye']
  append_env_path true
  strip_components 0
  action :install
end