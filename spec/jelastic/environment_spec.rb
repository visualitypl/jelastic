require 'spec_helper'

describe Jelastic::Environment do
  it 'creates an environment with normal node' do
    environment = Jelastic::Environment.create do |env|
      env.action_key = 'asdasd'
      env.region = 'Europe'
      env.with_high_availability
      env.engine = 'docker'
      env.display_name = 'Foo'
      env.with_ssl
      env.short_domain = 'foo-bar'

      env.add_node do |node|
        node.with_public_ip
        node.count = 1
        node.fixed_cloudlets = 1
        node.flexible_cloudlets = 2
        node.type = 'tomcat7'
      end
    end

    expect(environment).to have_attributes(
      action_key: 'asdasd',
      region: 'Europe',
      high_availability?: true,
      engine: 'docker',
      display_name: 'Foo',
      ssl?: true,
      short_domain: 'foo-bar'
    )
    expect(environment.nodes.first.class).to eq(Jelastic::Node)
    expect(environment.nodes.first).to have_attributes(
      public_ip?: true,
      count: 1,
      fixed_cloudlets: 1,
      flexible_cloudlets: 2,
      type: 'tomcat7'
    )
  end

  it 'creates an environment with docker node' do
    environment = Jelastic::Environment.create do |env|
      env.add_docker_node do |node|
        node.with_public_ip
        node.count = 1
        node.fixed_cloudlets = 1
        node.flexible_cloudlets = 2
        node.as_application_server
        node.image = 'nginx'
        node.set_registry 'jan', 'secret', 'registry.com'
        node.links = ['redis:redis']
        node.envs = {'foo' => 'bar'}
      end
    end

    expect(environment.nodes.first).to have_attributes(
      public_ip?: true,
      count: 1,
      fixed_cloudlets: 1,
      flexible_cloudlets: 2,
      type: 'docker',
      envs: {'foo' => 'bar'},
      links: ['redis:redis'],
    )
    expect(environment.nodes.first.registry).to have_attributes(
      user: 'jan',
      password: 'secret',
      url: 'registry.com'
    )
  end
end
