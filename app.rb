$LOAD_PATH.unshift 'lib'
require 'capitan'

# start the server if ruby file executed directly
Capitan::Server.run! if __FILE__ == $0