class Job < ActiveRecord::Base

  has_many :branches
  has_many :builds
  belongs_to :stack

  scope :enabled, where(enabled: true)

  attr_accessor :master_branch

  MAX_BRANCHES_PER_JOB = 100

  def self.sync(jobs_data)
    jobs_data.each do |job_data|
      find_or_create_by_name(job_data.name)
    end
    job_names = jobs_data.map(&:name)
    Job.all.each do |job|
      job.update_attribute(:enabled, job_names.include?(job.name))
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

  def branch_ids_to_preserve
    branches.select('id').order('last_build_number DESC').limit(self.class.max_branches_per_job)
  end

  def last_builds_by_branch
    builds.joins(:branch).
      includes(:branch).
      where('builds.number = branches.last_build_number').
      order('last_build_number DESC').limit(7)
  end

  def display_name
    name
  end

  def result
    master_branch.try(:result)
  end

  def success?
    master_branch.try(:success?)
  end

  def failure?
    master_branch.try(:failure?)
  end


  def unknown_status?
    master_branch.unknown_status?
  end

  def master_branch
    @master_branch ||= branches.where(:name => master_branch_name).first
  end

  def master_branch_name
    'origin/master'
  end

  def disable!
    update_attributes(enabled: false)
  end

  def enable!
    update_attributes(enabled: true)
  end

end