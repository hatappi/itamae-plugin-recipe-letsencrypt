require 'shellwords'

include_recipe 'command'

node.reverse_merge!(
  letsencrypt: {
    challenge_type: 'http-01',
    authenticator: 'standalone',
    debug_mode: false,
    snappy_executable: '/snap/bin/certbot',
    live_dir: '/etc/letsencrypt/live',
  }
)

node.validate! do
  {
    letsencrypt: {
      challenge_type: string,
      authenticator: string,
      debug_mode: boolean,
      snappy_executable: string,
      live_dir: string,

      domains: array_of(string),
      email: string,
      webroot_path: optional(string),
    }
  }
end

package 'snapd'

snappy 'certbot' do
  classic true
end

link node[:letsencrypt][:command] do
  to node[:letsencrypt][:snappy_executable]
end

# get each domain certificate
node[:letsencrypt][:domains].each do |domain|
  execute "get #{domain} certificate" do
    cmd = [
      node[:letsencrypt][:command],
      'certonly',
      '--agree-tos',
      "--domain", domain,
      "-m", node[:letsencrypt][:email],
      '-n', # Run non-interactively
      '--keep',
      "--authenticator", node[:letsencrypt][:authenticator],
      "--preferred-challenges", node[:letsencrypt][:challenge_type],
    ]
    cmd += ["--webroot", node[:letsencrypt][:webroot_path]] if node[:letsencrypt][:webroot_path]
    cmd << '--debug' if node[:letsencrypt][:debug_mode]
    command cmd.shelljoin

    dir = File.join(node[:letsencrypt][:live_dir], domain)
    exists = ["test", "-d", dir].shelljoin
    not_if exists
  end
end
