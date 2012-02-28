class Branch < ActiveRecord::Base
  serialize :build_numbers, Array

  belongs_to :job
  has_many :builds

  delegate :name, :to => :job, :prefix => true

  MAX_BUILDS_PER_BRANCH = 25

  def self.sync(job, branches_data)
    branches_data.each do |branch_data|
      job.find_or_initialize_branch_by_name(branch_data.name).tap do |branch|
        branch.last_build_number = branch_data.number
        branch.save
      end
    end
  end

  def self.build_ids_to_preserve
    includes(:builds).map(&:build_ids_to_preserve).inject(&:+)
  end

  def self.max_builds_per_branch
    MAX_BUILDS_PER_BRANCH
  end

  def build_ids_to_preserve
    builds.select('id').order('number DESC').limit(self.class.max_builds_per_branch)
  end

  def last_build_number=(number)
    return false if build_numbers.include?(number)
    build_numbers << number
  end

  def last_build_number
    build_numbers.last
  end

end
