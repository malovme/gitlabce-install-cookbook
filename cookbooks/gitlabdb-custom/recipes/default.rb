#
# Cookbook:: gitlabdb-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if %w[db_master db_slave].include?(node['dna']['instance_role'])
  require "pg"

  c = PGconn.connect(:user=>'postgres')
  c.exec("CREATE EXTENSION pg_trgm;")
end
