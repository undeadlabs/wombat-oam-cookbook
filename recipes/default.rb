#
# Cookbook Name:: wombat-oam
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

node.normal[:erlang][:esl][:version] = "1:17.1"

include_recipe "libarchive::default"
include_recipe "erlang::esl"
include_recipe "runit::default"

group node[:wombat_oam][:group]

user node[:wombat_oam][:owner] do
  group node[:wombat_oam][:group]
  system true
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
  cwd node[:wombat_oam][:_release_path]
  command "./generate.sh"
  not_if { File.exist?("#{node[:wombat_oam][:_release_path]}/rel/wombat/wombat/bin") }
end

runit_service "wombat-oam" do
  action :enable
end
