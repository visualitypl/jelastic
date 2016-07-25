require 'jelastic/node'
require 'jelastic/docker_node'

module Jelastic
  class Environment
    attr_accessor :action_key, :region, :engine, :display_name,
      :ssl, :short_domain, :nodes, :ssl, :high_availability
    attr_reader :client

    class << self
      private :new
    end

    def self.create(client, **params)
      environment = allocate
      environment.nodes = []

      yield(environment) if block_given?

      serialized_env = Serializers::Environment.new(environment).serialize
      client.create_environment(serialized_env)
    end

    def add_node
      node = Node.new
      nodes << node

      yield(node)

      nil
    end

    def add_docker_node
      node = DockerNode.new
      nodes << node

      yield(node)

      nil
    end

    def with_high_availability
      @high_availability = true
    end

    def high_availability?
      high_availability
    end

    def with_ssl
      @ssl = true
    end

    def ssl?
      ssl
    end
  end
end
