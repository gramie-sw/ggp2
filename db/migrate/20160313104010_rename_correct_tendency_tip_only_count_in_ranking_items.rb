class RenameCorrectTendencyTipOnlyCountInRankingItems < ActiveRecord::Migration
  def change
    rename_column :ranking_items, :correct_tendency_tips_only_count, :correct_tendeny_tips_count
  end
end
