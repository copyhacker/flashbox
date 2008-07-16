# Install hook code here
require 'fileutils'

%w{ images stylesheets javascripts }.each do |dir|
  puts "Installing #{dir}"
  Dir.glob File.join(File.dirname(__FILE__), "#{dir}/*") do |entry|
    FileUtils.cp entry, File.join(RAILS_ROOT, "public/#{dir}")
  end
end

puts IO.read(File.join(File.dirname(__FILE__), 'README'))