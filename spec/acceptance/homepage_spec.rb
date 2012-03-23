require 'acceptance/acceptance_helper'

feature 'Homepage', %q{
}, :vcr, :record => :new_episodes do

  scenario 'visit home page' do
    Factory(:job, :name => 'models')
    Factory(:job, :name => 'challenges')

    login_with_github

    visit '/?html=1'

    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

  scenario 'Login with Github' do
    team_member = setup_for_github_login
    Factory(:job, :name => 'models')
    visit '/'

    page.should_not have_content('models')

    click_link "login with github"

    page.should have_content team_member.login
    page.should have_content("logout")
    page.should have_content('models')

    click_link "logout"
    page.should_not have_content('models')
  end

end
