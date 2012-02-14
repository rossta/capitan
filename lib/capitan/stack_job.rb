module Capitan
  class StackJob < ActiveRecord::Base
    belongs_to :app
    belongs_to :job
  end
end
