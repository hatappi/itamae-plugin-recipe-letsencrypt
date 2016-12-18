node.reverse_merge!(
  letsencrypt: {
    certbot_auto_path: '/usr/bin/certbot-auto',
    cron_user: 'root',
    cron_file_path: '/etc/cron.d/itamae-letsencrypt',
    cron_configuration: true,
    challenge_type: 'http-01'
  }
)

execute 'download certbot-auto' do
  command "wget https://dl.eff.org/certbot-auto -O #{node[:letsencrypt][:certbot_auto_path]}"
end

execute 'change certbot-auto permission' do
  command "chmod a+x #{node[:letsencrypt][:certbot_auto_path]}"
end

execute 'install dependency package' do
  command "#{node[:letsencrypt][:certbot_auto_path]} -n --os-packages-only"
end

# get each domain certificate
node[:letsencrypt][:domains].each do |domain|
  execute "get #{domain} certificate" do
    command "#{node[:letsencrypt][:certbot_auto_path]} certonly --agree-tos -d #{domain} -m #{node[:letsencrypt][:email]} -a standalone --keep -n --standalone-supported-challenges #{node[:letsencrypt][:challenge_type]}"
  end
end

include_recipe 'letsencrypt::cron' if node[:letsencrypt][:cron_configuration]
