class RenameUsersToAuthentications < ActiveRecord::Migration
  def up
    rename_table :users, :authentications
  end

  def down
    rename_table :authentications, :users
  end
end
