class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|
      t.string :name, :null => false
      t.timestamps
    end

    add_column :jobs, :stack_id, :integer

    add_index :jobs, :stack_id
  end
end
