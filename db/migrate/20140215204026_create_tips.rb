class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.integer :user_id
      t.integer :match_id
      t.integer :score_team_1
      t.integer :score_team_2
      t.integer :points

      t.timestamps
    end
  end
end
