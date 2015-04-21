#
# Cookbook Name:: wombat-oam
# Recipe:: app
#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

case node['platform_family']
when 'debian'
  node.normal[:erlang][:esl][:version] = "1:17.3.2"
when 'rhel'
  node.normal[:erlang][:esl][:version] = "17.3-1.el6"
end

include_recipe "libarchive::default"
include_recipe "erlang::esl"
include_recipe "runit::default"

group node[:wombat_oam][:group]

user node[:wombat_oam][:owner] do
  group node[:wombat_oam][:group]
  home node[:wombat_oam][:home]
  system true
end

directory node[:wombat_oam][:home] do
  owner node[:wombat_oam][:owner]
  group node[:wombat_oam][:group]
  mode 0755
  recursive true
end

directory node[:wombat_oam][:log_dir] do
  mode 0755
  recursive true
end

asset = remote_file "#{Chef::Config[:file_cache_path]}/#{File.basename(node[:wombat_oam][:url])}" do
  source node[:wombat_oam][:url]
  checksum node[:wombat_oam][:checksum]
  backup false
end

libarchive_file File.basename(asset.path) do
  path asset.path
  extract_to node[:wombat_oam][:install_path]
  owner node[:wombat_oam][:owner]
  group node[:wombat_oam][:group]
end

execute "generate-release" do
  cwd node[:wombat_oam][:_srcpath]
  command "./generate.sh"
  user node[:wombat_oam][:owner]
  group node[:wombat_oam][:group]
  not_if { File.exist?("#{node[:wombat_oam][:_relpath]}/bin") }
end

template "#{node[:wombat_oam][:_relpath]}/releases/#{node[:wombat_oam][:version]}/vm.args" do
  source "vm.args.erb"
  owner node[:wombat_oam][:owner]
  group node[:wombat_oam][:group]
  mode 0644

  notifies :restart, "runit_service[wombat-oam]"
end

template "#{node[:wombat_oam][:_relpath]}/releases/#{node[:wombat_oam][:version]}/user.config" do
  source "user.config.erb"
  owner node[:wombat_oam][:owner]
  group node[:wombat_oam][:group]
  mode 0644

  notifies :restart, "runit_service[wombat-oam]"
end

runit_service "wombat-oam" do
  action :enable
end
