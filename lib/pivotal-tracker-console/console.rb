module PivotalTracker
  class Console  < Thor
    include Thor::Actions
    include API::Authentication
    include Displayable::Main
    include Displayable::Project

    #
    # Header
    #
    print_header
    
    #
    # Authentication
    #
    authenticate_by_token
    
    #
    # Tasks
    #
	
    # task: setup
  
  	desc "setup", "Setup the Pivotal Tracker API token"
    method_option :token, :type => :string, :required => true, :aliases => "-t"

  	def setup
  	  Setup::API::Authentication.token = options[:token]
  	  
  	  print_message "Token was setup."
  	end
  	
  	# task: projects

    desc "projects", "List all projects"
    method_option :details, :type => :boolean, :required => false, :aliases => "-d"

    def projects
      Project.all.each do |project|
        print_project_info project, :with_details => options.details?
      end
    end
  	
  	# task: project

    desc "project [ID]", "Show the project's details"

    def project(id)
      begin
        project = Project.find(id)
        print_project_info project
      rescue RestClient::ResourceNotFound
        print_project_not_found id
      end
    end
  end
end
