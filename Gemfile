source :rubygems

gem 'rails', '3.2.1'
gem 'sqlite3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.0.1'
end

# Assets
gem 'jquery-rails'
gem "rails-backbone"

# APIs
gem 'faraday', '0.8.0.rc2'
gem 'faraday_middleware'

# Views
gem 'draper'

# Auth
gem 'warden'
gem 'omniauth-github', :git => 'git://github.com/intridea/omniauth-github.git'

# Utils
gem 'whenever'

group :development, :test do
  gem 'ruby-debug19', :require => 'ruby-debug', :platforms => :mri_19
  gem 'ruby-debug',   :platforms => :mri_18

  gem 'rspec-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'steak'
  gem 'capybara-webkit'
end

group :test do
  gem 'fakeweb'
  gem 'vcr', "2.0.0.rc1"
  gem 'launchy'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
