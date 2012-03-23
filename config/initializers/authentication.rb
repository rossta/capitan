require 'garden_wall'
require 'omniauth-github'

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

module AuthStrategies
  class GeneralOmniauth < ::Warden::Strategies::Base
    def valid?
      omniauth.present?
    end

    def authenticate!
      if authentication = Authentication.find_by_provider_and_uid(omniauth["provider"], omniauth["uid"])
        success! authentication
      else
        fail 'Authentication'
      end
    end

    def omniauth
      request.env['omniauth.auth']
    end
  end
end
Warden::Strategies.add(:general_omniauth, AuthStrategies::GeneralOmniauth)


# ---
# :key: 1346369889ab8afc05ac
# :secret: 0fbb9fac12fc1139301331656f0289eecc410087
# :params:
#   code: cb122d928fd8bb4069fb
#   controller: sessions
#   action: create
#   provider: github
# :omniauth:
#   provider: github
#   uid: 11673
#   info:
#     nickname: rossta
#     email: rosskaff@gmail.com
#     name: Ross Kaffenberger
#     urls:
#       GitHub: https://github.com/rossta
#       Blog: http://www.rosskaff.com
#   credentials:
#     token: 15b4092c2ea99c1b6679522a99d84b8e68aaa2cd
#     expires: false
#   extra:
#     raw_info:
#       disk_usage: 41657
#       collaborators: 0
#       public_gists: 16
#       type: User
#       gravatar_id: b0169a78f851962058d63337ad0147d6
#       following: 19
#       hireable: false
#       avatar_url: https://secure.gravatar.com/avatar/b0169a78f851962058d63337ad0147d6?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png
#       login: rossta
#       private_gists: 3
#       blog: http://www.rosskaff.com
#       bio: !!null 
#       total_private_repos: 4
#       plan:
#         collaborators: 1
#         private_repos: 5
#         name: micro
#         space: 614400
#       location: New York City
#       company: http://www.challengepost.com
#       owned_private_repos: 4
#       url: https://api.github.com/users/rossta
#       html_url: https://github.com/rossta
#       created_at: '2008-05-27T18:27:16Z'
#       name: Ross Kaffenberger
#       email: rosskaff@gmail.com
#       id: 11673
#       public_repos: 37
#       followers: 10