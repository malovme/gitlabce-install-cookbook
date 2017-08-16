#
# Cookbook:: gitlabdb-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if %w[db_master db_slave].include?(node['dna']['instance_role'])
  execute 'psql command' do
    command 'sudo su postgres && psql -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"'
  end
end
