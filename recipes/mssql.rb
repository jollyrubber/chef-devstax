return unless platform?("windows")
::Chef::Recipe.send(:include, Windows::Helper)

remote_iso_url = node['chef-devstax']['mssql']['2014']['iso']['url']
remote_iso_checksum = node['chef-devstax']['mssql']['2014']['iso']['checksum']
sapwd = node['chef-devstax']['mssql']['sapwd']

# get iso
local_iso = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'mssql.iso'))
remote_file local_iso do
	source remote_iso_url
	checksum remote_iso_checksum
end

# get configuration ini
config_file = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'ConfigurationFile.ini'))
template config_file do
	source "ConfigurationFile.ini.erb"
	variables({
		:params => {
			:sqlsysadminaccounts => "vagrant"
		}
	})
end

# get powershell scripts
ps_script_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'scripts'))
ps_module_path = win_friendly_path(File.join(ps_script_path, 'MSSQLUnattendedInstall'))
remote_directory ps_script_path do
	source "scripts"
end

powershell_script "install_mssql" do
	cwd ps_script_path
	code <<-EOH
		Import-Module -Name #{ps_module_path}
		Install-MSSQL -ImagePath "#{local_iso}" -ConfigurationFile "#{config_file}" -SAPwd "#{sapwd}"
	EOH
end