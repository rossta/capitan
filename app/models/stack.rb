class Stack < ActiveRecord::Base
  has_many :jobs

  attr_accessible :job_ids, :name
  accepts_nested_attributes_for :jobs

  def display_name
    name.titleize
  end

  def result
    success? ? :success : 
      failure? ? :failure :
        :unknown
  end

  def result_description
    success? ? "Green" : "Red"
  end

  def success?
    jobs.all? { |job| job.success? }
  end

  def failure?
    jobs.any? { |job| job.failure? }
  end

  def unknown_status?
    jobs.any? { |job| job.unknown_status? }
  end
end
