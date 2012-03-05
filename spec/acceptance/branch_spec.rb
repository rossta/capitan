require 'acceptance/acceptance_helper'

feature 'Branch', %q{
  View branches
} do

  let(:user) { FactoryGirl.create(:user) }
  let(:job) { FactoryGirl.create(:job) }

  before do
    login_as user
  end

  scenario 'branches' do
    branch = FactoryGirl.create(:branch, :job => job, :name => 'origin/test_branch')
    build = FactoryGirl.create(:build, :branch => branch)

    visit '/'
    save_and_open_page
    click_link branch.name

    page.should have_content(branch.name)
    page.should have_content(build.name)
  end

end
