class CreateRankingItems < ActiveRecord::Migration
  def change
    create_table :ranking_items do |t|
      t.references :match, index: true
      t.references :user, index: true
      t.integer :position

      t.timestamps
    end
  end
end
