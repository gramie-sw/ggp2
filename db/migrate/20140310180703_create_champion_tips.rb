class CreateChampionTips < ActiveRecord::Migration
  def change
    create_table :champion_tips do |t|
      t.references :user, index: true
      t.references :team, index: true
      t.integer :result

      t.timestamps
    end
  end
end
