class Job < ActiveRecord::Base

  has_many :branches
  has_many :builds

  def self.sync(jobs_data)
    jobs_data.each do |job_data|
      find_or_create_by_name(job_data.name)
    end
  end

  def find_or_initialize_branch_by_name(branch_name)
    branches.find_or_initialize_by_name(branch_name)
  end

  def find_or_initialize_build_by_branch_id_and_number(branch_id, build_number)
    builds.find_or_initialize_by_branch_id_and_number(branch_id, build_number)
  end

end