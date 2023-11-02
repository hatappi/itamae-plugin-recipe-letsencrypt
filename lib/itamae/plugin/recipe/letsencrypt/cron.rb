include_recipe 'command'

node.reverse_merge!(
  letsencrypt: {
    cron: {
      user: 'root',
      file_path: '/etc/cron.d/itamae-letsencrypt',
    },
  }
)

node.validate! do
  {
    letsencrypt: {
      cron: {
        user: string,
        file_path: string,
      },
    }
  }
end

template node[:letsencrypt][:cron][:file_path] do
  variables user: node[:letsencrypt][:cron][:user],
            command: node[:letsencrypt][:command]
  source 'templates/etc/cron.d/itamae-letsencrypt.erb'
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
