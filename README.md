# Itamae::Plugin::Recipe::Letsencrypt

This gem is [itamae](https://github.com/ryotarai/itamae) plugin.
Get certificate of domain from [Let's Encrypt](https://letsencrypt.org/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-letsencrypt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-letsencrypt

## Support
- Debian GNU/Linux 8 (jessie)

I have not confirmed it in other environments yet
I will check in turn

## Usage

### Recipe

```rb
include_recipe "letsencrypt::get"
```

### Node
`itamae -y node.yml`

```yaml
# node.yml
letsencrypt:
  certbot_auto_path: /usr/bin/certbot-auto
  email: test@example.com
  cron_user: root
  cron_file_path: /etc/cron.d/itamae-letsencrypt
  cron_configuration: true
  challenge_type: 'http-01' # port80 is http-01, port443 is tls-sni-01
  domains:
    - test.example.com
    - test2.example.com
  authenticator: standalone # standalone, webroot
  webroot_path: /var/www/example
```

**Process of the port selected by `challenge_type` needs to be stopped**


## Contributing

1. Fork it ( https://github.com/hatappi/itamae-plugin-recipe-letsencrypt/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
