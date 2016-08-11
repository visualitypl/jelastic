require 'jelastic/request.rb'
require 'yaml'
require 'json'

module Jelastic
  module REST
    SYSTEM_APPID = '1dd8d191d38fff45e62564fcf67fdcd6'

    module Utils
      def send_request(path, params = {})
        Request.new(self, [path], params).send
      end

      def send_request_with_system_appid(path, params = {})
        send_request(path, params.merge(appid: SYSTEM_APPID))
      end

      def to_json(data, key)
        new_data = data.clone
        new_data[key] = new_data[key].to_json
        new_data
      end
    end
  end
end
