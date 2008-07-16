# Install hook code here
require 'fileutils'

%w{ images stylesheets javascripts }.each do |dir|
  Dir.glob "#{dir}/*" do |entry|
    FileUtils.cp entry, File.join(RAILS_ROOT, "public/#{dir}")
  end
end

