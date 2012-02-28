module Sync
  class Jenkins

    def self.ci
      ::Jenkins
    end

    def self.retrieve_and_sync_jobs
      Job.sync(ci.get_jobs)
    end

    def self.retrieve_and_sync_branches
      Job.all.each do |job|
        Branch.sync(job, ci.get_branches(job.name))
      end
    end

    def self.retrieve_and_sync_builds
      Job.includes(:branches).all.each do |job|
        job.branches.each do |branch|
          Build.sync(job, ci.get_build(job.name, branch.last_build_number, :branch_id => branch.id))
        end
      end
    end

  end
end