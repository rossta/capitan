class CreateDeploys < ActiveRecord::Migration
  def self.up
    create_table :deploys do |t|
      t.integer :provider_id
      t.string :commit
      t.string :ref
      t.string :resolved_ref
      t.boolean :successful
      t.string :user_name
      t.datetime :finished_at
      t.datetime :created_at
      t.string :migrate_command
      t.string :output

      t.integer :app_id
    end

    add_index :deploys, :finished_at
  end

  def self.down
    drop_table :deploys
  end
end