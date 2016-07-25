module REST
  module Control
    def create_environment(data = {})
      params = if data.respond_to?(:to_str)
         load_from_yml(data)
       else
         data
       end

      params = to_json(params, :env)
      params = to_json(params, :nodes)

      send_request('environment/control/rest/createenvironment', params)
    end

    def delete_environment(env_name)
      send_request('environment/control/rest/deleteenv', { envname: env_name, password: self.password })
    end

    def add_docker_volume(env_name:, node_id:, path:)
      send_request(
        'environment/control/rest/adddockervolume',
        { envname: env_name, node_id: node_id, path: path }
      )
    end

    def add_docker_volume(env_name:, group_id:, path:)
      send_request(
        'environment/control/rest/adddockervolumebygroup',
        { envname: env_name, group_id: group_id, path: path }
      )
    end

    def set_docker_env_vars(env_name:, node_id:, data:)
      send_request(
        'environment/control/rest/setdockerenvvars',
        { envname: env_name, node_id: node_id, data: data }
      )
    end
  end
end
