node.reverse_merge!(
  letsencrypt: {
    cron: {
      user: 'root',
      file_path: '/etc/cron.d/itamae-letsencrypt',
    },
    certbot_auto_path: '/usr/bin/certbot-auto',
  }
)

cron_text = <<-EOS
# DO NOT EDIT
# BECAUSE THIS CRON CREATE BY itamae-plugin-recipe-letsencrypt
0 0 1 * * #{node[:letsencrypt][:cron][:user]} #{node[:letsencrypt][:certbot_auto_path]} renew
EOS

file node[:letsencrypt][:cron][:file_path] do
  content cron_text
end

service_name = case node[:platform]
              when 'amazon'
                'crond'
              else
                'cron'
              end

service service_name do
  action :start
end
