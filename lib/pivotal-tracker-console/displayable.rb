module PivotalTracker
  module Displayable
    module Main
      def self.included(base)
        base.send :extend, self
      end

      def display_header
        display YELLOW, "\n:: Pivotal Tracker Console ::\n"
      end
      
      def display_message(message)
        display message
      end
      
      def display_error(message)
        display RED, "# Error => #{message}"
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
      def display_project_info(project, options = {:with_details => true})
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
    
    module Story
      def display_story_info(story, options = {:with_details => false})
        puts "Story: #{story}"
      end
    end
  end
end
