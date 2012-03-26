OmniAuth.config.test_mode = true

module GardenWallHelper
  def setup_for_github_login(team_member = dummy_team_member)
    OmniAuth.config.mock_auth[:github] = {
      "provider" => 'github',
      "uid" => team_member.id
    }
    organization = mock('Organization', :find_team_member => team_member)
    GardenWall.stub(:organization).and_return(organization)
    team_member
  end

  def login_with_github
    setup_for_github_login dummy_team_member
    visit root_path
    click_link 'github'
  end

  def dummy_team_member(attributes = {})
    GardenWall::Github::TeamMember.new(attributes.reverse_merge!(:id => 171, :login => "rossta"))
  end
end

RSpec.configuration.send(:include, GardenWallHelper)