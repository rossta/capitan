require 'acceptance/acceptance_helper'

feature 'Homepage', %q{
} do

  let(:user) { FactoryGirl.create(:user) }

  before do
    setup_for_github_login user
  end

  scenario 'visit home page' do
    Factory(:job, :name => 'models')
    Factory(:job, :name => 'challenges')

    login_as user

    visit '/'

    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

  scenario 'Login with Github' do
    visit '/'

    click_link "Login with Github"

    page.should have_content user.name
    page.should have_content("Log out")
  end
end
