require 'net/http'
require 'json'
require 'jelastic/request_error.rb'

class Request
  API_URL = 'https://app.jelastic.dogado.eu/1.0/'.freeze
  TIMEOUT = 300

  attr_reader :client, :path, :params

  def initialize(client, path, params = {})
    @client = client
    @path   = build_uri_path(path)
    @params = if client.authorized?
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
    uri = URI.join(API_URL, path)
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

      new_path[0] = '' if path[0] == '/'
      new_path[-1] = '' if path[-1] == '/'

      new_path
    end.join('/')
  end
end
