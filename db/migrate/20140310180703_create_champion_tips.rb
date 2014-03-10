class CreateChampionTips < ActiveRecord::Migration
  def change
    create_table :champion_tips do |t|

      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end
