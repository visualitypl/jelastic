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

    def set_docker_env_vars(env_name:, node_id:, data:)
      send_request(
        'environment/control/rest/setdockerenvvars',
        { envname: env_name, nodeId: node_id, data: data }
      )
    end

    def get_environments
      send_request_with_system_appid('environment/control/rest/getenvs')
    end
  end
end
