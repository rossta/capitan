require 'acceptance/acceptance_helper'

feature 'Homepage', %q{
} do

  let(:authentication) { FactoryGirl.create(:authentication) }

  scenario 'visit home page' do
    Factory(:job, :name => 'models')
    Factory(:job, :name => 'challenges')

    login_as authentication

    visit '/?html=1'

    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

  scenario 'Login with Github' do
    setup_for_github_login authentication
    Factory(:job, :name => 'models')
    visit '/'

    page.should_not have_content('models')

    click_link "login with github"

    page.should have_content authentication.name
    page.should have_content("logout")
    page.should have_content('models')

    click_link "logout"
    page.should_not have_content('models')
  end

end
