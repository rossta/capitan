require 'acceptance/acceptance_helper'

feature 'Homepage', %q{
} do

  scenario 'visit home page' do
    Factory(:job, :name => 'models')
    Factory(:job, :name => 'challenges')

    visit '/'

    page.should have_content('models')
    page.should have_content('challenges')

    within("#jobs") do
      click_link 'models'
    end

    page.should have_content('models')
  end

end
