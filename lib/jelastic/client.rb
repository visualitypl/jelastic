require 'jelastic/rest/api.rb'
require 'jelastic/user.rb'
require 'forwardable'

module Jelastic
  class Client
    include REST::API
    extend Forwardable

    attr_accessor :appid, :login, :password
    attr_reader :user

    def_delegator :user, :session

    def initialize(params = {})
      params.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      yield(self) if block_given?
    end

    def authorized?
      !user.nil?
    end

    def authorize
      @user = User.new(signin)

      nil
    end

    def logout
      if authorized?
        signout
        @user = nil
      end

      nil
    end
  end
end
