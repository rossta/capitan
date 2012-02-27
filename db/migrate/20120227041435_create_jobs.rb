class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end
end
