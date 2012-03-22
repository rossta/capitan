module Github
  class Organization < Base
    lazy_attr_reader :name

    def team_members
      @team_members ||= begin
        Collection.new do |collection|
          collection.member_class = TeamMember
          collection.url          = "/orgs/#{name}/members"
          collection.fetch
        end
      end
    end

    def team_member_ids
      team_members.map(&:id)
    end

    def team_member_attributes
      team_members.map(&:attributes)
    end

    def team_member?(team_member_id)
      team_member_ids.include?(team_member_id)
    end

    def refresh_team_members
      team_members.fetch
    end

  end
end