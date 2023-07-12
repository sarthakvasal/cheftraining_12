#
# Cookbook:: myhaproxy
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
haproxy_install 'package'
haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'server_backend'
end
web_nodes = search('node', "policy_name:company_web AND policy_group:#{node.policy_group}")
server_array = []

web_nodes.each do |one_node|
  one_server = "#{one_node['cloud']['public_hostname']} #{one_node['cloud']['public_ipv4']}:80 maxconn 32"
  server_array.push(one_server)
end

haproxy_backend 'server_backend' do
  server server_array
end
haproxy_service 'haproxy' do
  subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :delayed
end
