#
# Cookbook Name:: wombat-oam
# Recipe:: app_proxy
#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

include_recipe "nginx::default"

nginx_site "default" do
  enable false
end

template "#{node[:nginx][:dir]}/sites-available/wombat-oam.conf" do
  source "nginx-wombat-oam.conf.erb"
  notifies :reload, "service[nginx]"
end

nginx_site "wombat-oam.conf" do
  enable true
end
