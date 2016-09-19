require 'jelastic/rest/api'
require 'jelastic/user'
require 'forwardable'

module Jelastic
  class Client
    include REST::API
    extend Forwardable

    attr_accessor :login, :password, :api_url
    attr_reader :user

    def_delegator :user, :session

    def initialize(params = {})
      params.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      yield(self) if block_given?
    end

    def authenticated?
      !user.nil?
    end

    def authenticate
      @user = User.new(signin)

      nil
    end

    def logout
      if authenticated?
        signout
        @user = nil
      end

      nil
    end
  end
end
