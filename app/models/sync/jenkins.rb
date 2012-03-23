module Sync
  class Jenkins

    def self.ci
      ::Jenkins
    end

    def self.retrieve_and_sync_jobs
      Job.sync(ci.get_jobs)
    end

    def self.retrieve_and_sync_branches
      Job.enabled.each do |job|
        Branch.sync(job, ci.get_branches(job.name))
      end
    end

    def self.retrieve_and_sync_builds
      Job.includes(:branches).enabled.each do |job|
        job.branches.each do |branch|
          Build.sync(branch, ci.get_build(job.name, branch.last_build_number, :branch_id => branch.id))
        end
      end
    end

    def self.job_by_name(job_name)
      Job.where(:name => job_name).each do |job|
        Branch.sync(job, ci.get_branches(job.name))
        job.branches.each do |branch|
          Build.sync(branch, ci.get_build(job.name, branch.last_build_number, :branch_id => branch.id))
        end
      end
    end

  end
end
