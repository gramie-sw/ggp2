class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :game_number
      t.integer :aggregate_id
      t.integer :team_1_id
      t.integer :team_2_id
      t.integer :score_team_1
      t.integer :score_team_2
      t.string :placeholder_team_1
      t.string :placeholder_team_2
      t.datetime :date

      t.timestamps
    end
  end
end
