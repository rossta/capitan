class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name,         :null => false
      t.integer :job_id,      :null => false
      t.integer :last_build_number
      t.timestamps
    end

    add_index :branches, :job_id
  end
end