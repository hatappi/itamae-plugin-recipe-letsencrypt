cron_text = <<-EOS
# DO NOT EDIT
# BECAUSE THIS CRON CREATE BY itamae-plugin-recipe-letsencrypt
0 0 1 * * #{node[:letsencrypt][:cron_user]} #{node[:letsencrypt][:certbot_auto_path]} renew
EOS

execute 'set cron file' do
  command "echo '#{cron_text}' > #{node[:letsencrypt][:cron_file_path]}"
end

service "cron" do
  action :start
end
