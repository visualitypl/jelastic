module Jelastic
  module Serializers
    class Environment < Base
      attr_reader :environment

      def initialize(environment)
        @environment = environment
      end

      def serialize
        hash = {
          actionkey: environment.action_key,
          env: env_hash,
          nodes: []
        }

        environment.nodes.each do |node|
          if node.docker?
            hash[:nodes] << docker_node_hash(node)
          else
            hash[:nodes] << node_hash(node)
          end
        end

        clean(hash)
      end

      def env_hash
        {
          region: environment.region,
          ishaenabled: environment.high_availability?,
          engine: environment.engine,
          displayName: environment.display_name,
          sslstate: environment.ssl?,
          shortdomain: environment.short_domain
        }
      end

      def node_hash(node)
        {
          extip: node.public_ip?,
          count: node.count,
          fixedCloudlets: node.fixed_cloudlets,
          flexibleCloudlets: node.flexible_cloudlets,
          displayName: node.display_name,
          nodeType: node.type
        }
      end

      def docker_node_hash(node)
        node_hash(node).merge(
          {
            docker: {
              cmd: node.cmd,
              image: node.image,
              links: node.links,
              env: node.envs,
              registry: node.registry.to_h,
              nodeGroup: node.group
            }
          }
        )
      end
    end
  end
end
