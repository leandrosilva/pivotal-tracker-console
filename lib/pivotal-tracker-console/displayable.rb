module PivotalTracker
  module Displayable
    module Main
      def self.included(base)
        base.send :extend, self
      end

      def display_header
        puts "\n:: Pivotal Tracker Console ::\n\n"
      end
      
      def display_message(message)
        puts message
      end
      
      def display_error(message)
        display_message "# Error => #{message}"
      end
    end

    module Project
      def display_project_info(project, options)
        puts "Project: #{project.id} - #{project.name}"

        if options[:with_details]
          puts %Q{
    - Week start day:   #{project.week_start_day}
    - Point scale:      #{project.point_scale}
    - Velocity scheme:  #{project.velocity_scheme}
    - Iteration lenght: #{project.iteration_length}
    - Initial velocity: #{project.initial_velocity}
    - Current velocity: #{project.current_velocity}
    - Last activity at: #{project.last_activity_at}
          }
        end
      end
      
      def display_project_not_found(id)
        display_error "Project #{id} not found."
      end
    end
  end
end
