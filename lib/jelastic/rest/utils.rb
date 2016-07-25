require 'jelastic/request.rb'
require 'yaml'
require 'json'

module REST
  module Utils
    def send_request(path, params = {})
      Request.new(self, [path], params).send
    end

    def load_from_yaml(path, file)
      YAML.load_file(file)
    end

    def to_json(data, key)
      new_data = data.clone
      new_data[key] = new_data[key].to_json
      new_data
    end
  end
end
