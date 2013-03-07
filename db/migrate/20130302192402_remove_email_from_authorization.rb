class RemoveEmailFromAuthorization < ActiveRecord::Migration
  def up
    remove_column :authorizations, :email
  end

  def down
    add_column :authorizations, :email, :string
  end
end
