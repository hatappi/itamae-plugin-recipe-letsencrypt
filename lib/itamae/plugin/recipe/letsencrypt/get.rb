require 'shellwords'

node.reverse_merge!(
  letsencrypt: {
    certbot_auto_path: '/usr/bin/certbot-auto',
    challenge_type: 'http-01',
    authenticator: 'standalone',
    debug_mode: false,
  }
)

execute 'download certbot-auto' do
  download = ["wget", "https://dl.eff.org/certbot-auto", "-O", node[:letsencrypt][:certbot_auto_path]].shelljoin
  command download

  exists = ["test", "-f", node[:letsencrypt][:certbot_auto_path]].shelljoin
  not_if exists
end

execute 'change certbot-auto permission' do
  make_executable = ["chmod", "a+x", node[:letsencrypt][:certbot_auto_path]].shelljoin
  command make_executable

  executable_exists = ["test", "-x", node[:letsencrypt][:certbot_auto_path]].shelljoin
  not_if executable_exists
end

execute 'install dependency package' do
  cmd = [node[:letsencrypt][:certbot_auto_path], "-n", "--os-packages-only"].shelljoin
  cmd << '--debug' if node[:letsencrypt][:debug_mode]
  command cmd.shelljoin

  dry_run = [*cmd, '--dry-run'].shelljoin
  detect = ["grep", "OS packages installed."].shelljoin
  not_if "test -n $(#{dry_run} | #{detect})"
end

# get each domain certificate
node[:letsencrypt][:domains].each do |domain|
  execute "get #{domain} certificate" do
    cmd = [
      node[:letsencrypt][:certbot_auto_path],
      'certonly',
      '--agree-tos',
      "-d", domain,
      "-m", node[:letsencrypt][:email],
      "-a", node[:letsencrypt][:authenticator],
      '--keep',
      '-n',
      "--preferred-challenges", node[:letsencrypt][:challenge_type],
    ]
    cmd += ["-w", node[:letsencrypt][:webroot_path]] if node[:letsencrypt][:webroot_path]
    cmd << '--debug' if node[:letsencrypt][:debug_mode]
    command cmd.shelljoin

    dir = File.join("/etc/letsencrypt/live", domain)
    exists = ["test", "-d", dir].shelljoin
    not_if exists
  end
end
