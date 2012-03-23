require 'garden_wall/capybara_helper'
RSpec.configuration.send :include, GardenWall::CapybaraHelper
OmniAuth.config.test_mode = true