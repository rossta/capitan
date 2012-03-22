module Github
  class TeamMember < Base
    lazy_attr_reader :id, :login, :url
    
  end
end