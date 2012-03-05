class Job < ActiveRecord::Base

  has_many :branches
  has_many :builds

  scope :enabled, where(enabled: true)

  MAX_BRANCHES_PER_JOB = 100

  def self.sync(jobs_data)
    jobs_data.each do |job_data|
      find_or_create_by_name(job_data.name)
    end
  end

  def self.max_branches_per_job
    MAX_BRANCHES_PER_JOB
  end

  def self.branch_ids_to_preserve
    includes(:branches).map(&:branch_ids_to_preserve).inject(&:+)
  end

  def find_or_initialize_branch_by_name(branch_name)
    branches.find_or_initialize_by_name(branch_name)
  end

  def find_or_initialize_build_by_branch_id_and_number(branch_id, build_number)
    builds.find_or_initialize_by_branch_id_and_number(branch_id, build_number)
  end

  def branch_ids_to_preserve
    branches.select('id').order('last_build_number DESC').limit(self.class.max_branches_per_job)
  end

  def last_builds_by_branch
    builds.joins(:branch).
      includes(:branch).
      where('builds.number = branches.last_build_number').
      order('last_build_number DESC')
  end

  def display_name
    name
  end

  def disable!
    update_attributes(enabled: false)
  end

  def enable!
    update_attributes(enabled: true)
  end

end