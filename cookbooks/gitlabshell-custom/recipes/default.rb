#
# Cookbook:: gitlabshell-custom
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

  gitlabshell_secret_path = '/home/git/gitlab-shell/.gitlab_shell_secret'
  if File.exist?(gitlabshell_secret_path) && File.symlink?(gitlabshell_secret_path)
    file gitlabshell_secret_path do
      action :delete
    end
  end
  unless File.exist?(gitlabshell_secret_path)
    file gitlabshell_secret_path do
      content SecureRandom.hex(16)
      owner 'deploy'
      group 'deploy'
      mode '0755'
    end
  end

  execute 'sudo -u deploy bundle exec rake gitlab:shell:install RAILS_ENV=production SKIP_STORAGE_VALIDATION=true' do
    cwd release_dir
  end
end