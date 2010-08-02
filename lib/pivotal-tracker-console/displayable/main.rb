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

      def display(color_code = nil, text = nil)
        if color_code
          puts "\e[#{color_code}#{text}\e[0m"
        else
          puts text
        end
      end
    end
  end
end
