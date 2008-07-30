module Flashbox
  FLASH_KEY = :feedback
  
  module ControllerMethods
    def add_info(message)
      add_feedback(message, 'info')
    end
    
    def add_warning(message)
      add_feedback(message, 'warning')
    end
    
    def add_error(message)
      add_feedback(message, 'error')
    end
    
  protected
    
    # Add to the queue of feedback to be rendered to the user.
    def add_feedback(message, level)
      flash[FLASH_KEY] = [ message, level ]
    end
  end
  
  module Helpers
    # Returns a javascript tag that bootstraps the feedback system once the
    # page has loaded.
    def flashbox_init
      javascript_tag do
        script = "jQuery.noConflict();"

        if flash[:feedback]
          script += <<-SCRIPT
            jQuery(document).ready(function($) {
              jQuery.facebox('#{flash[:feedback].first}', 'feedback #{flash[:feedback].last}');
            }) 
            SCRIPT
        end
        
        script 
      end
    end
  end


  module JavaScriptGeneratorMethods
    def add_info(message)
      add_feedback(message, 'info')
    end
    
    def add_warning(message)
      add_feedback(message, 'warning')
    end
    
    def add_error(message)
      add_feedback(message, 'error')
    end
    
    
  protected
  
    # Add to the queue of feedback to be rendered to the user.
    def add_feedback(message, level)
      self << "jQuery.facebox('#{message}', 'feedback #{level}');"
    end
  end
end
