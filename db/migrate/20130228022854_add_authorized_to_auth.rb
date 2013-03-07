class AddAuthorizedToAuth < ActiveRecord::Migration
  def change
    add_column :auths, :authorized, :boolean
  end
end
