class RenameLastTokenToTokenOfAuthorization < ActiveRecord::Migration
  def up
    rename_column :authorizations, :last_token, :session_token
  end

  def down
    rename_column :authorizations, :session_token, :last_token
  end
end
