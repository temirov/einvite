class RemoveAuthorizationIDsFromUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.remove_references :authorization
    end
    remove_column :users, :authorization_id 
  end

  def down
    change_table :users do |t|
      t.references :authorization
    end
    add_index :users, :authorization_id
  end
end
