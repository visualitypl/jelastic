require 'jelastic/rest/utils'
require 'jelastic/rest/authentication'
require 'jelastic/rest/control'

module REST
  module API
    include REST::Utils
    include REST::Authentication
    include REST::Control
  end
end
