class RemovePasswordFromAuthorization < ActiveRecord::Migration
  def up
    remove_column :authorizations, :password
  end

  def down
    add_column :authorizations, :password, :string
  end
end
