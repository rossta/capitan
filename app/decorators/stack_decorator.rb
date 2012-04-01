class StackDecorator < ApplicationDecorator
  decorates :stack
  decorates_association :jobs

  def display_result
    result.to_s
  end

  def as_json(options = {})
    {
      :id => id,
      :name => display_name,
      :display_result => display_result,
      :result_description => result_description
    }.tap do |json|
      json[:jobs] = jobs_as_json
    end
  end

  def jobs_as_json
    jobs.map do |job|
      {
        :id => job.id,
        :name => job.name,
        :display_result => job.display_result
      }
    end
  end


end