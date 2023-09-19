node.reverse_merge!(
  letsencrypt: {
    cron: {
      user: 'root',
      file_path: '/etc/cron.d/itamae-letsencrypt',
    },
    command: '/usr/bin/certbot',
  }
)

node.validate! do
  {
    letsencrypt: {
      cron: {
        user: string,
        file_path: string,
      },
      command: string,
    }
  }
end

cron_text = <<-EOS
# DO NOT EDIT
# BECAUSE THIS CRON CREATE BY itamae-plugin-recipe-letsencrypt
0 0 1 * * #{node[:letsencrypt][:cron][:user]} #{node[:letsencrypt][:command]} renew
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
