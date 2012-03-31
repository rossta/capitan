class StackDecorator < ApplicationDecorator
  decorates :stack
  decorates_association :jobs

  def display_result
    result.to_s
  end

end