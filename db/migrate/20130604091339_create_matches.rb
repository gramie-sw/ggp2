class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :position
      t.references :aggregate, index: true
      t.references :team_1, index: true
      t.references :team_2, index: true
      t.integer :score_team_1
      t.integer :score_team_2
      t.string :placeholder_team_1
      t.string :placeholder_team_2
      t.references :venue, index: true
      t.datetime :date

      t.timestamps
    end
  end
end
