module PivotalTracker
  module Displayable
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
