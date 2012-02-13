require './app'

use Rack::ShowExceptions
run Capitan::Server.new