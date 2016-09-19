require 'net/http'
require 'json'
require 'jelastic/request_error'

module Jelastic
  class Request
    TIMEOUT = 1200

    attr_reader :client, :path, :params

    def initialize(client, path = [], params = {})
      @client = client
      @path   = build_uri_path(path)
      @params = if client.authenticated?
          params.merge(
            session: client.session,
          )
        else
          params.merge(
            login:    client.login,
            password: client.password
          )
        end
    end

    def send
      uri = URI.join(client.api_url, path)
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(params)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = TIMEOUT

      res = http.request(req)
      out = JSON.parse(res.body)

      unless out['result'].zero?
        raise RequestError.new(out['error'], out)
      else
        out
      end
    end

    private

    def build_uri_path(path)
      path.map do |item|
        new_path = item

        new_path[0] = '' if new_path[0] == '/'
        new_path[-1] = '' if new_path[-1] == '/'

        new_path
      end.join('/')
    end
  end
end
