class CreateStackJobs < ActiveRecord::Migration

  def self.up
    create_table :stack_jobs do |t|
      t.integer :job_id
      t.integer :stack_id
      t.string  :role
    end

    add_index :stack_jobs, [:stack_id, :job_id]
  end

  def self.down
    drop_table :stack_jobs
  end

end