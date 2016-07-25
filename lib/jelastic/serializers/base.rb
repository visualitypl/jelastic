module Jelastic
  module Serializers
    class Base
      private

      def clean(hash = {})
        new_hash = {}

        hash.each do |key, value|
          if value.respond_to?(:to_hash) && value.length > 0
            new_hash[key] = clean(value)
          elsif value.respond_to?(:to_ary)
            new_hash[key] = []
            value.each do |v|
              new_hash[key] << clean(v)
            end
          elsif !value.nil?
            new_hash[key] = value
          end
        end

        new_hash
      end
    end
  end
end
