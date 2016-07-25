module Jelastic
  class Node
    attr_accessor :count, :fixed_cloudlets, :flexible_cloudlets, :display_name, :type

    def initialize
      yield(self) if block_given?
    end

    def with_public_ip
      @public_ip = true
    end

    def public_ip?
      @public_ip
    end

    def docker?
      @type == 'docker'
    end
  end
end
