class AddAuthorizationIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :authorization_id, :integer
    add_index :users, :authorization_id
  end
end
