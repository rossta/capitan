Capybara.javascript_driver = :webkit

module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.

  def auto_login!
    setup_for_github_login
    visit root_path
  end

end

RSpec.configuration.include HelperMethods, :type => :acceptance