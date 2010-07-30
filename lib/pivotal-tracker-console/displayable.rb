module PivotalTracker
  module Displayable
    module Main
      def self.included(base)
        base.send :extend, self
      end

      def display_header
        display YELLOW, "\n:: Pivotal Tracker Console ::\n"
      end
      
      def display_text(text, new_line = :no)
        display text
        
        puts "" if new_line == :new_line
      end
      
      def display_error(message)
        display RED, "# Error => #{message}"
      end
      
      def skip_one_line
        puts ""
      end
      
      private

      RED     = "31m"
      GREEN   = "31m"
      YELLOW  = "33m"
      BLUE    = "34m"
      MAGENTA = "35m"

      def display(color_code = nil, text)
        if color_code
          puts "\e[#{color_code}#{text}\e[0m"
        else
          puts text
        end
      end
    end

    module Project
      def display_project_title(project)
        puts "#{project.id} - #{project.name}"
      end

      def display_project_info(project)
        display_project_title project
        
        puts %Q{
  - Week start day:   #{project.week_start_day}
  - Point scale:      #{project.point_scale}
  - Velocity scheme:  #{project.velocity_scheme}
  - Iteration lenght: #{project.iteration_length}
  - Initial velocity: #{project.initial_velocity}
  - Current velocity: #{project.current_velocity}
  - Last activity at: #{project.last_activity_at}
  
  Stories count:
  
    - Features:  #{project.stories.all(:story_type => ["feature"]).count}
    - Chores:    #{project.stories.all(:story_type => ["chore"]).count}
    - Bugs:      #{project.stories.all(:story_type => ["bug"]).count}
}
      end
      
      def display_project_not_found(id)
        display_error "Project #{id} not found."
      end
    end
    
    module Story
      def display_story_info(story, options = {:with_details => true})
        unless options[:with_details]
          puts "  - #{story.story_type}: #{story.id} [#{story.current_state}]"
        else
          puts %Q{
  - Story: #{story.id} [#{story.current_state}]
           
    "#{story.name}"
    
    - Type: #{story.story_type}
    - Created at: #{story.created_at}
    - Estimate: #{story.estimate}
    - Requested by: #{story.requested_by}
    - Owned by: #{story.owned_by}
    - Labels: #{story.labels}
    
    What more?
    
      #{story.description}
}
        end
      end
      
      def display_story_not_found(id)
        display_error "Story #{id} not found."
      end
    end
  end
end
