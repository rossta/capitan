class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :number, :null => false
      t.boolean :building
      t.datetime :built_at
      t.integer :branch_id
      t.integer :job_id
      t.string :result_message
      t.timestamps
    end

    # add_index :builds, [:branch_id, :number]
    # add_index :builds, [:job_id, :number]
  end
end