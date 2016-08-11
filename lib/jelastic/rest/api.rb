require 'jelastic/rest/utils'
require 'jelastic/rest/authentication'
require 'jelastic/rest/control'

module Jelastic
  module REST
    module API
      include REST::Utils
      include REST::Authentication
      include REST::Control
    end
  end
end
