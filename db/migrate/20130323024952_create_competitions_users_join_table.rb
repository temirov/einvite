class CreateCompetitionsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :competitions_users, :id => false do |t|
      t.integer :user_id
      t.integer :competition_id
    end
    add_index :competitions_users, :user_id
    add_index :competitions_users, :competition_id
  end
end
