require "rubygems"
require "thor"
require "pivotal-tracker"
require "ap"

require "config/api"

module PivotalTracker
  class Console  < Thor
    include Thor::Actions

    #
    # Tasks
    #
	
    # task: setup
  
  	desc "setup", "Setup the Pivotal Tracker API token"
    method_option :token, :type => :string, :required => true, :aliases => "-t"

  	def setup
  	  Config::API.token = options[:token]
  	end
  	
  	# task: projects

    desc "projects", "List projects"

    def projects
      initialize_client
      
      projects = Project.all
      
      ap projects
    end
    
    private
    
    def initialize_client
      Client.token = Config::API.token
    end
  end
end
