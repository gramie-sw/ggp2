module RankingItems
  class FindWinners

    Result = Struct.new(:first_places, :second_places, :third_places)

    def run
      ranking_items = RankingItemQueries.winner_ranking_items

      result = Result.new
      result.first_places= ranking_items_with_position(1, ranking_items)
      result.second_places = ranking_items_with_position(2, ranking_items)
      result.third_places = ranking_items_with_position(3, ranking_items)
      result
    end

    private

    def ranking_items_with_position(position, ranking_items)
      ranking_items.select { |ranking_item| ranking_item.position == position }
    end
  end
end