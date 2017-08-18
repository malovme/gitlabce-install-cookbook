#
# Cookbook:: custom-gitlab-workhorse
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if %w[util app app_master].include?(node['dna']['instance_role'])
  execute 'gitlab-workhorse step_1' do
    cwd '/home/git'
    command 'sudo -u deploy -H git clone https://gitlab.com/gitlab-org/gitlab-workhorse.git'
  end

  execute 'gitlab-workhorse step_2' do
    cwd '/home/git/gitlab-workhorse'
    command 'sudo -u deploy -H git checkout v0.7.8'
  end

  execute 'gitlab-workhorse step_3' do
    cwd '/home/git/gitlab-workhorse'
    command 'sudo -u deploy -H make'
  end
end
