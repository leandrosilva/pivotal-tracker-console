require "yaml"

module PivotalTracker
  module Config
    class API
      class << self
        def token=(token)
          File.open(filename, 'w') { |file| file.write "token: #{token}" }
        end
        
        def token
          @token ||= YAML.load_file(filename)['token']
        end
        
        private
        
        def filename
          File.expand_path("~/.pivotal_tracker")
        end
      end
    end
  end
end
