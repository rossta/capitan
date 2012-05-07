require 'acceptance/acceptance_helper'

feature 'Jobs', %q{
  View current jobs
} do

  before { auto_login! }

  scenario 'visit jobs', :js => true do
    FactoryGirl.create(:job, :name => 'models')
    FactoryGirl.create(:job, :name => 'challenges')

    visit jobs_path

    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

  scenario 'visit jobs, non-js' do
    FactoryGirl.create(:job, :name => 'models')
    FactoryGirl.create(:job, :name => 'challenges')

    visit jobs_path(:html => 1)

    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

end
