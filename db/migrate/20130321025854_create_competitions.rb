class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :competitions, :user_id
  end
end
