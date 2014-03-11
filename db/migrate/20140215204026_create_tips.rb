class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.references :user, index: true
      t.references :match, index: true
      t.integer :score_team_1
      t.integer :score_team_2
      t.integer :result

      t.timestamps
    end
  end
end
