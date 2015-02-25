return unless platform?("windows")
::Chef::Recipe.send(:include, Windows::Helper)

remote_iso_url = node['chef-devstax']['msoffice']['2013']['professional']['iso']['url']
remote_iso_checksum = node['chef-devstax']['msoffice']['2013']['professional']['iso']['checksum']

# get iso
local_iso = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'msoffice.iso'))
remote_file local_iso do
	source remote_iso_url
	checksum remote_iso_checksum
end

# get deployment xml
config_xml_file = win_friendly_path(File.join(Dir.tmpdir(), 'Config.xml'))
template config_xml_file do
	source "Config.xml.erb"
	variables({
		:params => {
			:username => "Vagrant"
		}
	})
end

# get powershell scripts
ps_script_path = win_friendly_path(File.join(Dir.tmpdir(), 'scripts'))
remote_directory ps_script_path do
	source "scripts"
end

# execute install script
ps_module_path = win_friendly_path(File.join(ps_script_path, 'MSOfficeUnattendedInstall'))
powershell_script "install_msoffice" do
	cwd ps_script_path
	code <<-EOH
		Import-Module -Name #{ps_module_path}
		Install-MSOffice -ImagePath "#{local_iso}" -ConfigFile "#{config_xml_file}"
	EOH
end

file local_iso do
	action :delete
end
file config_xml_file do
	action :delete
end