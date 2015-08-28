module Ranking
  class FindCurrentBase < UseCase

    def run

      if ::Property.champion_tip_ranking_set_exists?
        ranking_by_match_id(nil)
      else

        match_id = ::Property.last_tip_ranking_set_match_id

        if match_id.nil?
          neutral_ranking
        else
          ranking_by_match_id(match_id)
        end
      end

    end
  end

  private

  # template method
  def neutral_ranking
  end

  # template method
  def ranking_by_match_id(match_id)
  end
end