#
# Cookbook Name:: wombat-oam
# Attributes:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

default[:wombat_oam][:version]      = "0.8.0"
default[:wombat_oam][:url]          = "https://s3-us-west-2.amazonaws.com/ul-chef/wombat-#{node[:wombat_oam][:version]}.tar.gz"
default[:wombat_oam][:checksum]     = "6969831c8157a70280e05bd7e50bd136f5e2beadc1e8711d1a245a0ffc45e751"
default[:wombat_oam][:user]         = "wombat"
default[:wombat_oam][:group]        = "wombat"
default[:wombat_oam][:install_path] = "/opt/wombat-oam"
default[:wombat_oam][:log_dir]      = "/var/log/wombat-oam"

#
# Private
#

force_override[:wombat_oam][:_release_path] = "#{node[:wombat_oam][:install_path]}/wombat-#{node[:wombat_oam][:version]}"