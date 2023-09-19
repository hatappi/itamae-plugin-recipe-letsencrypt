# Itamae::Plugin::Recipe::Letsencrypt

This gem is an [Itamae][] plugin for getting the [Let's Encrypt][le] certificates with [Certbot][].

[Certbot]: https://certbot.eff.org/
[Itamae]: https://github.com/ryotarai/itamae
[le]: https://letsencrypt.org/

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'itamae-plugin-recipe-letsencrypt'
```

And then execute `bundle`.
Or install it yourself as `gem install itamae-plugin-recipe-letsencrypt`.

## Support

- [Debian GNU/Linux 10 (buster)][buster]

[buster]: https://www.debian.org/releases/buster/

Contributions are welcome for other platforms.

## Usage

### Recipe

```ruby
include_recipe "letsencrypt::get"
```

### Node

```yaml
# node.yml
letsencrypt:
  domains:
    - test.example.com
    - test2.example.com
  email: test@example.com
  webroot_path: /var/www/example
```

```shell
itamae -y node.yml
```

Other attributes are set to defaults as in `lib/itamae/plugin/recipe/letsencrypt/get.rb`.
Note that process of the port selected by `challenge_type` needs to be stopped.

## Contributing

1. [Fork it][fork]
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[fork]: https://github.com/hatappi/itamae-plugin-recipe-letsencrypt/fork

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
