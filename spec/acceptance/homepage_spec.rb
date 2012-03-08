require 'acceptance/acceptance_helper'

feature 'Homepage', %q{
} do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'visit home page' do
    Factory(:job, :name => 'models')
    Factory(:job, :name => 'challenges')

    login_as user

    visit '/?html=1'

    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

  scenario 'Login with Github' do
    setup_for_github_login user
    Factory(:job, :name => 'models')
    visit '/'

    page.should_not have_content('models')

    click_link "login with github"

    page.should have_content user.name
    page.should have_content("logout")
    page.should have_content('models')

    click_link "logout"
    page.should_not have_content('models')
  end

end
