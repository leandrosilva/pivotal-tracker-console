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
    - Feature stories:  #{project.stories.all(:story_type => ["feature"]).count}
    - Chore stories:    #{project.stories.all(:story_type => ["chore"]).count}
    - Bug stories:      #{project.stories.all(:story_type => ["bug"]).count}
          }
        end
      end
      
      def display_project_not_found(id)
        display_error "Project #{id} not found."
      end
    end
    
    module Story
      def display_story_info(story, options = {:with_details => true})
        puts %Q{    Story: #{story.id}
      #{story.name}
        }
      end
    end
  end
end

# #<PivotalTracker::Story:0x7a5ce4 @id=3673737, @url="http://www.pivotaltracker.com/story/show/3673737",
#                                 @created_at=#<DateTime: 2010-05-26T12:38:34+00:00 (106070818757/43200,0/1,2299161)>, @accepted_at=nil,
#                                 @name="Hospedagem IDC n\xC3\xA3o s\xC3\xA3o removidas",
#                                 @description="Clientes IDC hoje pedem o cancelamento de sua HP inclusa, o provisioning fica em deletado por\xC3\xA9m n\xC3\xA3o \xC3\xA9 removido do servidor e com isso o cadastro do servi\xC3\xA7o n\xC3\xA3o e limpo e o Dom\xC3\xADnio fica preso. Causando um futuro problema de contrata\xC3\xA7\xC3\xA3o de servi\xC3\xA7o. Conforme an\xC3\xA1lise j\xC3\xA1 feita pelo Gustavo Santana a programa\xC3\xA7\xC3\xA3o est\xC3\xA1 incorreta, pois chama apenas servi\xC3\xA7os \"HOSTING\" mas IDC o servi\xC3\xA7o \xC3\xA9 \"HP_INCLUSA....\"",
#                                 @story_type="bug", @estimate=-1, @current_state="unscheduled", @requested_by="Anderson V Silva", @owned_by=nil,
#                                 @labels="central do cliente", @jira_id=nil, @jira_url=nil, @other_id=nil, @project_id=31234>
