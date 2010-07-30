module PivotalTracker
  module Displayable
    module Story
      def display_story_title(story)
        puts "  - #{story.story_type.capitalize}: #{story.id} [#{story.current_state}]"
      end
      
      def display_story_info(story)
        display_story_title(story)
        
        puts %Q{
    "#{story.name}"
    
    - Created at: #{story.created_at}
    - Estimate: #{story.estimate}
    - Requested by: #{story.requested_by}
    - Owned by: #{story.owned_by}
    - Labels: #{story.labels}
    
    What more?
    
      #{story.description}
}
      end
      
      def display_story_not_found(id)
        display_error "Story #{id} not found."
      end
    end
  end
end
