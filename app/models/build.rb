class Build < ActiveRecord::Base

  belongs_to :job
  belongs_to :branch

  def self.sync(job, attributes = {})
    build_data = attributes[:data]
    build = job.find_or_initialize_build_by_number(build_data.build_number).tap do |build|
      build.branch_id   = attributes[:branch_id]
      build.building    = build_data.building
      build.finished_at = build_data.timestamp
      build.result_message = build_data.result
    end
    build.save
  end

  def self.display_results
    includes(:job, :branch).order('job_id DESC, number DESC').all.each do |build|
      puts "#{build.job_name} ##{build.number}:\t\t\t#{build.branch_name}\t\t\t#{build.result.to_s}"
    end
  end

  def job_name
    job.name
  end

  def branch_name
    branch.name
  end

  def result
    Jenkins.result_for(result_message) || :unknown
  end

end
