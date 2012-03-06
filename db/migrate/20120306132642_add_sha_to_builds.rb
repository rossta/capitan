class AddShaToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :sha, :string, :default => '', :null => false

    add_index :builds, :sha
  end
end
