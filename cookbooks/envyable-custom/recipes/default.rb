#
# Cookbook:: envyable-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if %w[util app app_master].include?(node['dna']['instance_role'])
  current_path = "/data/gitlabce/current"
  failed_path = "/data/gitlabce/releases_failed"

  if File.exist?(current_path)
    release_dir = current_path
  else
    release_dir = failed_path + '/' +
        Dir.entries(failed_path).select {|entry| File.directory? File.join(failed_path, entry) and !(entry =='.' || entry == '..') }.sort.last
  end

  execute 'sudo -u deploy bundle exec envyable install' do
    cwd release_dir
  end
end