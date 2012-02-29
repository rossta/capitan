class AddEnabledFlagToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :enabled, :boolean, :default => true
  end
end