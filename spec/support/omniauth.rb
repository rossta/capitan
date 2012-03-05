OmniAuth.config.test_mode = true

module OmniauthHelpers
  def setup_for_github_login(user)
    OmniAuth.config.mock_auth[user.provider.to_sym] = {
      "provider" => user.provider,
      "uid" => user.uid
    }
  end

  def login_as(user)
    setup_for_github_login user
    visit '/'
    click_link 'login with github'
  end
end

RSpec.configuration.send :include, OmniauthHelpers