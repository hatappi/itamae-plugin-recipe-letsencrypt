node.reverse_merge!(
  letsencrypt: {
    command: '/usr/bin/certbot',
  }
)

node.validate! do
  {
    letsencrypt: {
      command: string,
    }
  }
end
