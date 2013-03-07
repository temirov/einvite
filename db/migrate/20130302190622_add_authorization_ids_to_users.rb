class AddAuthorizationIdsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :authorization
    end

    add_index :users, :authorization_id
  end
end
