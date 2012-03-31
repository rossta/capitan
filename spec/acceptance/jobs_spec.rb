require 'acceptance/acceptance_helper'

feature 'Jobs', %q{
  View current jobs
} do

  scenario 'visit jobs', :js => true do
    FactoryGirl.create(:job, :name => 'models')
    FactoryGirl.create(:job, :name => 'challenges')

    login_with_github

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

    login_with_github

    visit jobs_path(:html => 1)

    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

end
