class CreateChampionTips < ActiveRecord::Migration
  def change
    create_table :champion_tips do |t|
      t.references :user, index: true
      t.references :team, index: true

      t.timestamps
    end
  end
end
