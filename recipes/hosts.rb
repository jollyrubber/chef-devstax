unless node["chef-devstax"]["hosts"]
	Chef::Application.fatal! "chef-devstax.host attribute cannot be nil. Please populate that attribute."
end

node["chef-devstax"]["hosts"].each do |h, a|
	hostsfile_entry a do
		hostname  h
		action    "create_if_missing"
	end
end