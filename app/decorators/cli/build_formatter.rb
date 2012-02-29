module CLI

  class BuildFormatter
    def initialize(builds)
      @builds = builds
    end

    def to_s
      [].tap do |status|
        @builds.each do |build|
          status << "".tap do |output|
            output << "%-21s" % "#{build.job_name} ##{build.number}:"
            output << "%-42s" % build.branch_display_name
            output << "%-8s" % build.result.to_s
          end
        end
      end.join("\n")
    end
  end

end
