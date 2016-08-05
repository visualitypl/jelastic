module Jelastic
  class RequestError < StandardError
    attr :response

    def initialize(what, response)
      super(what)

      @response = response
    end
  end
end
