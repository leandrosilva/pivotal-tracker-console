module PivotalTracker
  class Console  < Thor
    include Thor::Actions
    include API::Authentication
    include Displayable::Main
    include Displayable::Project
    include Displayable::Story

    #
    # Header
    #
    display_header
    
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
  	  
  	  display_message "Token was setup."
  	end
  	
  	# task: projects

    desc "projects", "List all projects"
    method_option :details, :type => :boolean, :required => false, :aliases => "-d"

    def projects
      Project.all.each do |project|
        display_project_info project, :with_details => options.details?
      end
    end
  	
  	# task: project

    desc "project [ID]", "Show the project's details and its stories"
    method_option :stories, :type => :boolean, :required => false, :aliases => "-s"

    def project(id)
      begin
        project = Project.find(id)
        display_project_info project
        
        project.stories.all.each do |story|
          display_story_info story
        end
      rescue RestClient::ResourceNotFound
        display_project_not_found id
      end
    end
  end
end
