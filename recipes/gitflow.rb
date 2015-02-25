return unless platform?("ubuntu")

include_recipe "git"

gitflow_installer = "#{Chef::Config[:file_cache_path]}/gitflow-installer.sh"
remote_file gitflow_installer do
	source "http://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh"
	action "create_if_missing"
	mode "0744"
end
execute "install_gitflow" do
	command "sh #{gitflow_installer}"
end