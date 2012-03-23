OmniAuth.config.test_mode = true

module OmniauthHelpers
  def setup_for_github_login(team_member = dummy_team_member)
    OmniAuth.config.mock_auth[:github] = {
      "provider" => 'github',
      "uid" => team_member.id
    }
    organization = mock('organization')
    GardenWall.stub(:organization).and_return(organization)
    organization.stub(:find_team_member).and_return(team_member)
    team_member
  end

  def login_with_github
    setup_for_github_login dummy_team_member
    visit root_path
    click_link 'login with github'
  end

  def dummy_team_member
    GardenWall::Github::TeamMember.new(:id => 171, :login => "rossta")
  end
end

RSpec.configuration.send :include, OmniauthHelpers