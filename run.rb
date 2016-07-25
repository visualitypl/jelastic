require 'jelastic'

client = Jelastic::Client.new do |config|
  config.appid    = ENV['appid']
  config.login    = ENV['login']
  config.password = ENV['password']
end

begin
  client.authorize

  Jelastic::Environment.create(client) do |env|
    env.action_key = 'asdasd'
    env.short_domain = 'foadasd'

    env.add_docker_node do |node|
      node.count = 1
      node.fixed_cloudlets = 1
      node.flexible_cloudlets = 2
      node.display_name = 'nginx'
      node.as_application_server
      node.image = 'nginx'
      node.envs = {'foo' => 'bar'}
    end
  end

  client.delete_environment('foadasd')
rescue => e
  puts e.message
ensure
  client.logout
  puts client.authorized?
end
