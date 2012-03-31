require 'acceptance/acceptance_helper'

feature 'Login', %q{
}, :vcr, :record => :new_episodes do

  before do
    Capitan::Application.config.stub!(:enable_github_authentication).and_return(true)
  end

  scenario 'Login with Github' do
    team_member = setup_for_github_login
    FactoryGirl.create(:job, :name => 'models')
    visit root_path

    page.should_not have_content('models')

    click_link "github"

    page.should have_content team_member.login
    page.should have_content("logout")
    page.should have_content('models')

    click_link "logout"
    page.should_not have_content('models')
  end

end
