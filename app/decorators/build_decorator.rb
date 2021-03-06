class BuildDecorator < ApplicationDecorator
  decorates :build

  def display_result
    result.to_s
  end

  def display_revision
    build.sha[0..8]
  end

  def built_at
    h.l build.built_at, :format => :human
  end

  def synced_at
    h.l build.updated_at, :format => :human
  end

  def as_json(options = {})
    {
      number: number,
      job_branch_path: h.job_branch_path(job, branch),
      branch_display_name: branch_display_name,
      display_revision: display_revision,
      display_result: display_result,
      built_at:   built_at,
      synced_at:  synced_at,
      id:         id,
      branch_id:  branch_id,
      building:   building,
      job_id:     job_id,
      result_message: result_message,
      sha:        sha,
      finished:   finished?
    }
  end

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #
  #   Or, optionally enable "lazy helpers" by including this module:
  #     include Draper::LazyHelpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #
  #   def created_at
  #     h.content_tag :span, time.strftime("%a %m/%d/%y"),
  #                   :class => 'timestamp'
  #   end
end