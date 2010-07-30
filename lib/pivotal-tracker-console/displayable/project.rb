module PivotalTracker
  module Displayable
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
  end
end
