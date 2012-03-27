require 'opensesame-github/capybara'
OmniAuth.config.test_mode = true
RSpec.configuration.send(:include, OpenSesame::Github::Capybara)