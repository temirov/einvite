class AddPasswordDigestToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :password_digest, :string
  end
end
