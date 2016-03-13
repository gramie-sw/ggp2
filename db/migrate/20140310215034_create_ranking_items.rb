class CreateRankingItems < ActiveRecord::Migration
  def change
    create_table :ranking_items do |t|
      t.references :match, index: true
      t.references :user, index: true
      t.integer :position
      t.boolean :correct_champion_tip
      t.integer :correct_tips_count
      t.integer :correct_tendeny_tips_count
      t.integer :points

      t.timestamps
    end
  end
end
