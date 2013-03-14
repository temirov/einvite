class AddPlainPasswordToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :plain_password, :string
  end
end
