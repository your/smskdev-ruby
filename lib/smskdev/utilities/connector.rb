require 'net/http'

module Smskdev
  module Utilities
    class Connector
      def self.get(request)
        Net::HTTP.get(URI.parse(request))
      end
    end
  end
end