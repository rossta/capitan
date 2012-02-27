class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.string :job_id
      t.integer :number       # like provider_id
      t.string :result
      t.string :branch
      t.string :sha
      t.datetime :built_at
      t.integer :duration
    end

    add_index :builds, :number
  end

  def self.down
    drop_table :builds
  end
end