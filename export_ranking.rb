def write_to_file(ranking_item)
  File.write('./tmp/exported_ranking.txt',
             "#{ranking_item.position}. " +
                 "#{ranking_item.user.nickname}, " +
                 "Points: #{ranking_item.points}, " +
                 "Correct Tips: #{ranking_item.correct_tips_count}, " +
                 "Correct Winners: #{ranking_item.correct_tendency_tips_only_count}, " +
                 "Correct Champion Tip: #{ranking_item.correct_champion_tip}\n",
             mode: 'a')
end

RankingSets::FindCurrent.new.run.each do |ranking_item|
  write_to_file(ranking_item)
end
RankingSets::FindCurrent.new(page: 2).run.each do |ranking_item|
  write_to_file(ranking_item)
end
RankingSets::FindCurrent.new(page: 3).run.each do |ranking_item|
  write_to_file(ranking_item)
end



