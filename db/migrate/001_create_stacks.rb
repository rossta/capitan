class CreateStacks < ActiveRecord::Migration
  def self.up
    create_table :stacks do |t|
      t.string :title
    end

    add_index :stacks, :title
  end

  def self.down
    drop_table :stacks
  end
end