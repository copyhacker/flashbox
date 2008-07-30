require 'flashbox'

# Install controller methods
ActionController::Base.class_eval do
  include Flashbox::ControllerMethods
  helper Flashbox::Helpers
end

# Install JavaScriptGenerator methods
ActionView::Helpers::PrototypeHelper::JavaScriptGenerator::GeneratorMethods.module_eval do
  include Flashbox::JavaScriptGeneratorMethods
end
