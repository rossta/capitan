class BuildPoller

  def self.retrieve_and_sync_jobs
    Job.sync(Jenkins.api_jobs)
  end

  def self.retrieve_and_sync_branches
    Job.all.each do |job|
      Branch.sync(job, Jenkins.api_branches(job.name))
    end
  end

  def self.retrieve_and_sync_builds
    Job.includes(:branches).all.each do |job|
      job.branches.each do |branch|
        retrieve_and_sync_builds_for_job_branch(job, branch)
      end
    end
  end

  def self.retrieve_and_sync_builds_for_job_branch(job, branch)
    Build.sync(job, :branch_id => branch.id, :data => Jenkins.api_job_build(job.name, branch.last_build_number))
  end

end