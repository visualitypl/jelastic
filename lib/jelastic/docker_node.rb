module Jelastic
  class DockerNode < Node
    attr_accessor :cmd, :image, :links, :envs
    attr_reader :registry, :group

    DockerRegistry = Struct.new(:user, :password, :url)

    def initialize
      @type = 'docker'

      super
    end

    def as_application_server
      @group = 'cp'
    end

    def as_load_balancer
      @group = 'bl'
    end

    def as_no_sql_database
      @group = 'nosqldb'
    end

    def as_sql_database
      @group = 'sqldb'
    end

    def as_cache
      @group = 'cache'
    end

    def as_extra_layaer
      @group = nil
    end

    def set_registry(user, password, url = nil)
      @registry = DockerRegistry.new(user, password, url)
    end
  end
end
