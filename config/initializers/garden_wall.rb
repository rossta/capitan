require 'garden_wall'

GardenWall.configure do |c|
  c.organization = 'challengepost'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :challengepost, ENV['CHALLENGEPOST_APP_ID'], ENV['CHALLENGEPOST_APP_SECRET']
  provider :github, ENV['CAPITAN_GITHUB_KEY'], ENV['CAPITAN_GITHUB_SECRET']
end

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_scope = :team_member
  manager.scope_defaults :team_member, :strategies => [:github_team_member]
  manager.failure_app = lambda { |env| HomeController.action(:show).call(env) }
end