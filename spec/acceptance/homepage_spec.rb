require 'acceptance/acceptance_helper'

feature 'Homepage', %q{
} do

  before do
    Capitan::Application.config.stub!(:enable_github_authentication).and_return(false)
  end

  scenario 'visit home page', :js => true do
    stack   = create(:stack, :name => 'topic_action')
    job     = stack.jobs.create(attributes_for(:job, :name => 'topic_action'))
    branch  = job.branches.create(attributes_for(:branch, :name => 'origin/master'))
    build   = branch.builds.create(attributes_for(:build))

    visit root_path

    page.should have_content('Stacks')

    within("#stacks") do
      page.should have_content('Status')
      page.should have_content('Topic Action')
      page.should have_content('Green')
    end

  end

end
