require 'flashbox'

# Install controller methods
ActionController::Base.class_eval do
  include Flashbox::ControllerMethods
  helper Flashbox::Helpers
end
