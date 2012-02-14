class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :name
    end

    add_index :jobs, :name
  end

  def self.down
    drop_table :jobs
  end
end