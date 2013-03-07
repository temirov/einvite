class RemoveAuthorizedFromAuthorization < ActiveRecord::Migration
  def up
    remove_column :authorizations, :authorized
  end

  def down
    add_column :authorizations, :authorized, :boolean
  end
end
