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
    branch  = FactoryGirl.create :branch, \
      :job => job, 
      :name => 'origin/test_branch', 
      :last_build_number => 123
      
    build   = FactoryGirl.create :build, \
      :branch => branch,
      :number => 123,
      :result_message => "SUCCESS",
      :sha => "a1b2c3d4"

    visit '/?html=1'

    click_link branch.name

    page.should have_content(branch.name)
    page.should have_content(build.number)
    page.should have_content("success")
    page.should have_content("a1b2c3d4")
  end

end
