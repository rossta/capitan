class Build < ActiveRecord::Base

  belongs_to :job
  belongs_to :branch

  scope :status, includes(:job, :branch).order('job_id DESC, number DESC')
  scope :ordered_by_number, order('number DESC')

  def self.sync(job, build_data)
    return false unless build_data.branch_id && build_data.build_number

    job.find_or_initialize_build_by_branch_id_and_number(build_data.branch_id, build_data.build_number).tap do |build|
      build.building    = build_data.building
      build.built_at    = build_data.built_at
      build.result_message = build_data.result
      build.save
    end
  end

  def self.trim_by_branch
    destroy_all(["id NOT IN (?)", Branch.build_ids_to_preserve])
  end

  def job_name
    job.name
  end

  def branch_display_name
    branch.display_name
  end

  def result
    Jenkins.result_for(result_message) || :unknown
  end

end
