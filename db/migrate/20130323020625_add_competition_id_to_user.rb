class AddCompetitionIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :competition_id, :integer
    add_index :users, :competition_id
  end
end
