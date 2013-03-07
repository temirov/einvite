class DropAuthsTable < ActiveRecord::Migration
  def up
    drop_table :auths
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
