require 'spec_helper'

describe Jelastic::Serializers::Environment do
  it 'converts to hash' do
    client = instance_double('Client')
    allow(client).to receive(:create_environment).and_return(true)

    environment = Jelastic::Environment.create(client) do |env|
      env.action_key = 'asdasd'
      env.region = 'Europe'
      env.with_high_availability
      env.engine = 'docker'
      env.display_name = 'Foo'
      env.with_ssl
      env.short_domain = 'foo-bar'

      env.add_docker_node do |node|
        node.with_public_ip
        node.cmd = 'start.sh'
        node.count = 1
        node.fixed_cloudlets = 1
        node.flexible_cloudlets = 2
        node.display_name = 'nginx'
        node.as_application_server
        node.image = 'nginx'
        node.set_registry 'jan', 'secret', 'registry.com'
        node.links = ['redis:redis', 'postgres:db']
        node.envs = {'foo' => 'bar'}
      end
    end

    hash = Jelastic::Serializers::Environment.new(environment).serialize

    expected_hash = {
      actionkey: 'asdasd',
      env: {
        region: 'Europe',
        ishaenabled: true,
        engine: 'docker',
        displayName: 'Foo',
        sslstate: true,
        shortdomain: 'foo-bar'
      },
      nodes: [
        {
          extip: true,
          count: 1,
          fixedCloudlets: 1,
          flexibleCloudlets: 2,
          displayName: 'nginx',
          nodeType: 'docker',
          docker: {
            cmd: 'start.sh',
            image: 'nginx',
            links: ['redis:redis', 'postgres:db'],
            env: { 'foo' => 'bar' },
            registry: { user: 'jan', password: 'secret', url: 'registry.com' },
            nodeGroup: 'cp'
          }
        }
      ]
    }

    expect(hash).to eq(expected_hash)
  end
end
