module PivotalTracker
  module API
    module Authentication
      def self.included(base)
        base.send :extend, self
      end
    
      def authenticate_by_token
        Client.token = Setup::API::Authentication.token if Setup::API::Authentication.has_token?
      end
    end
  end
end