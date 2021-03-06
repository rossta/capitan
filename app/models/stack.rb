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
    success? ? "Green - Build stack passing, app is deploy ready" :
      failure? ? "Red - Build failing, don't deploy" :
        "Yellow - Build status unknown, don't deploy"
  end

  def success?
    jobs.all? { |job| job.success? } && jobs.map(&:sha).uniq.size == 1
  end

  def failure?
    jobs.any? { |job| job.failure? }
  end

  def unknown_status?
    jobs.any? { |job| job.unknown_status? }
  end
end
