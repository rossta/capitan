dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require 'rack/test'
require 'database_cleaner'

# Configure Rack Environment
ENV["RACK_ENV"] ||= 'test'

require 'capitan'

# Load factories
require 'factory_girl'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

TestRedis::Server.start!(dir)

def app
  Capitan::Server
end
