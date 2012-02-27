class Branch < ActiveRecord::Base
  serialize :build_numbers, Array

  belongs_to :job
  has_many :builds

  def self.sync(job, branches_data)
    branches_data.each do |branch_data|
      job.find_or_initialize_branch_by_name(branch_data.name).tap do |branch|
        branch.last_build_number = branch_data.number
        branch.save
      end
    end
  end

  delegate :name, :to => :job, :prefix => true

  def last_build_number=(number)
    return false if build_numbers.include?(number)
    build_numbers << number
  end

  def last_build_number
    build_numbers.last
  end

end
