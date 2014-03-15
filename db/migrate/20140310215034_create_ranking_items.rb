class CreateRankingItems < ActiveRecord::Migration
  def change
    create_table :ranking_items do |t|
      t.references :match, index: true
      t.references :user, index: true
      t.integer :position
      t.integer :correct_tips_count
      t.integer :correct_tendency_tips_only_count

      t.timestamps
    end
  end
end
