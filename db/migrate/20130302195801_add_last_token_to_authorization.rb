class AddLastTokenToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :last_token, :string
    add_index :authorizations, :last_token
  end
end
