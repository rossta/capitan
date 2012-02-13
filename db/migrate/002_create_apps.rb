class CreateApps < ActiveRecord::Migration
  def self.up
    # provider_id, :account, :name, :repository_uri, :api

    create_table :apps, :force => true do |t|
      t.integer :provider_id
      t.string  :name
      t.string  :account_name

      t.integer :stack_id
      t.timestamps
    end
  end
end