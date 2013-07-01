$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'timeclock'
require 'timecop'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

EXAMPLE_PROJECT_PATH = File.join(File.dirname(__FILE__), "example_project")

def path(filename)
  File.join(EXAMPLE_PROJECT_PATH, filename)
end
