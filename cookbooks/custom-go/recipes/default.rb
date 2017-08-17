#
# Cookbook:: custom-go
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if %w[app_master app].include?(node['dna']['instance_role'])
  directory '/usr/local/go' do
    recursive true
    action :delete
  end

  execute 'go step_1' do
    command 'curl --remote-name --progress https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz'
  end

  execute 'go step_2' do
    command "echo '1862f4c3d3907e59b04a757cfda0ea7aa9ef39274af99a784f5be843c80c6772  go1.8.3.linux-amd64.tar.gz' | shasum -a256 -c - && \
  sudo tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz"
  end

  execute 'go step_3' do
    command 'sudo ln -sf /usr/local/go/bin/{go,godoc,gofmt} /usr/local/bin/'
  end

  execute 'go step_4' do
    command 'rm go1.8.3.linux-amd64.tar.gz'
  end
end
