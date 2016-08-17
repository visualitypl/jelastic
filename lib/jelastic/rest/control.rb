module Jelastic
  module REST
    module Control
      def create_environment(params = {})
        params = to_json(params, :env)
        params = to_json(params, :nodes)

        send_request_with_system_appid('environment/control/rest/createenvironment', params)
      end

      def delete_environment(env_name)
        send_request(
          'environment/control/rest/deleteenv',
          { envname: env_name, password: self.password }
        )
      end

      def add_docker_volume(env_name:, node_id:, path:)
        send_request(
          'environment/control/rest/adddockervolume',
          { envname: env_name, nodeId: node_id, path: path }
        )
      end

      def add_docker_volume_by_group(env_name:, group_id:, path:)
        send_request(
          'environment/control/rest/adddockervolumebygroup',
          { envname: env_name, groupId: group_id, path: path }
        )
      end

      def set_docker_env_vars(env_name:, node_id:, envs:)
        data = envs.to_json

        send_request(
          'environment/control/rest/setdockerenvvars',
          { envname: env_name, nodeId: node_id, data: data }
        )
      end

      def get_docker_env_vars(env_name:, node_id:)
        send_request(
          'environment/control/rest/getdockerenvvars',
          { envname: env_name, nodeId: node_id }
        )
      end

      def get_environment(env_name)
        send_request('environment/control/rest/getenvinfo', { envname: env_name })
      end

      def get_environments
        send_request_with_system_appid('environment/control/rest/getenvs')
      end

      def redeploy_containers_by_group(env_name:, node_group:, tag:, sequential: false, use_existing_volumes: false)
        send_request(
          'environment/control/rest/redeploycontainersbygroup',
          { envname: env_name, nodeGroup: node_group, tag: tag, sequential: sequential, useExistingVolumes: use_existing_volumes }
        )
      end

      def redeploy_container_by_id(env_name:, node_id:, tag:, use_existing_volumes: false)
        send_request(
          'environment/control/rest/redeploycontainerbyid',
          { envname: env_name, nodeId: node_id, tag: tag, useExistingVolumes: use_existing_volumes }
        )
      end
    end
  end
end
