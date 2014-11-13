#
# Cookbook Name:: wombat-oam
# Attributes:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

default[:wombat_oam][:version]       = "1.1.0"
default[:wombat_oam][:url]           = "https://s3-us-west-2.amazonaws.com/ul-chef/wombat-#{node[:wombat_oam][:version]}.tar.gz"
default[:wombat_oam][:checksum]      = "c8e472f03b9c64b25380202d492bfa1dd0409c93752de92def2793c245dbd883"
default[:wombat_oam][:owner]         = "wombat"
default[:wombat_oam][:group]         = "wombat"
default[:wombat_oam][:install_path]  = "/opt/wombat-oam"
default[:wombat_oam][:log_dir]       = "/var/log/wombat-oam"
default[:wombat_oam][:erlang_cookie] = "wombat"
default[:wombat_oam][:otp_name]      = "wombat@#{node[:fqdn]}"
default[:wombat_oam][:home]          = "/home/wombat"
default[:wombat_oam][:host]          = node[:fqdn]

default[:wombat_oam][:kernel][:inet_dist_listen_min] = 10000
default[:wombat_oam][:kernel][:inet_dist_listen_max] = 50000

#
# Private
#

force_override[:wombat_oam][:_srcpath] = "#{node[:wombat_oam][:install_path]}/wombat-#{node[:wombat_oam][:version]}"
force_override[:wombat_oam][:_relpath] = "#{node[:wombat_oam][:_srcpath]}/rel/wombat/wombat"
