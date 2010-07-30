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
  	  
  	  display_text "Token was setup."
  	end
  	
  	# task: projects

    desc "projects", "List all projects"

    def projects
      display_text "All projects", :new_line
      
      Project.all.each do |project|
        display_project_title project
      end
    end
  	
  	# task: project

    desc "project [ID]", "Show the project's details and its stories"

    def project(id)
      display_text "Details about project", :new_line

      begin
        project = Project.find(id)
        display_project_info project
      rescue RestClient::ResourceNotFound
        display_project_not_found id
      end
    end
  	
  	# task: stories

    desc "stories [PROJECT_ID]", "Show the project's stories"
    method_option :project, :type => :numeric, :required => true, :aliases => "-p"
    method_option :type, :type => :array, :required => false, :default => ["feature", "chore", "bug"], :aliases => "-t"

    def stories
      project_id = options.project
      
      begin
        project = Project.find(project_id)
        display_project_info project
        skip_one_line

        project.stories.all(:story_type => options.type).each do |story|
          display_story_info story, :with_details => false
        end
      rescue RestClient::ResourceNotFound
        display_project_not_found project_id
      end
    end
  	
  	# task: story

    desc "story [ID]", "Show the story's details"
    method_option :project, :type => :numeric, :required => true, :aliases => "-p"

    def story(id)
      project_id = options.project
      
      begin
        project = Project.find(project_id)
        display_project_info project

        story = project.stories.find(id.to_i)
        
        if story
          display_story_info story
        else
          skip_one_line
          display_error "Story #{id} not found in the project #{project_id}"
        end
      rescue RestClient::ResourceNotFound
        display_project_not_found id
      end
    end
  end
end
