require 'acceptance/acceptance_helper'

feature 'Homepage', %q{
} do

  before do
    Capitan::Application.config.stub!(:enable_github_authentication).and_return(false)
  end

  scenario 'visit home page', :js => true do
    pending
    Factory(:job, :name => 'models')
    Factory(:job, :name => 'challenges')

    visit '/?html=1'
    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

end
