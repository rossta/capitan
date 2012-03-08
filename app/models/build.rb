class Build < ActiveRecord::Base

  belongs_to :job
  belongs_to :branch

  scope :status, includes(:job, :branch).order('job_id DESC, number DESC')
  scope :ordered_by_number, order('number DESC')

  after_create :denormalize_job_id

  def self.sync(branch, build_data)
    return false unless build_data.build_number

    branch.find_or_initialize_build_by_number(build_data.build_number).tap do |build|
      unless build.finished?
        build.building    = build_data.building
        build.built_at    = build_data.built_at
        build.result_message = build_data.result
      end
      build.sha         = build_data.sha
      build.touch
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
    Jenkins.result_for(result_message) || result_message
  end

  def finished?
    Jenkins.finished_result?(result_message)
  end

  def denormalize_job_id
    update_attribute(:job_id, branch.job_id)
  end

end
