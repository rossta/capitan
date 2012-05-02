require 'opensesame'

OpenSesame.configure do |config|
  config.auto_login   'github'
  config.github       ENV['CAPITAN_GITHUB_KEY'], ENV['CAPITAN_GITHUB_SECRET']
  config.organization 'challengepost'
  config.mounted_at   '/welcome'
end