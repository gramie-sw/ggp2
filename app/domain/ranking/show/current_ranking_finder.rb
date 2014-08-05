class CurrentRankingFinder

  def self.create_for_single_user
    CurrentRankingFinder.new(SingleUserRankingProvider)
  end

  def self.create_for_all_users
    CurrentRankingFinder.new(AllUserRankingProvider)
  end

  def initialize ranking_provider
    @ranking_provider = ranking_provider
  end

  def find options

    if Property.champion_tip_ranking_set_exists?
      ranking_provider.champion_tip_ranking(options)
    else

      last_tip_ranking_set_match_id = Property.last_tip_ranking_set_match_id

      if last_tip_ranking_set_match_id.nil?
        ranking_provider.neutral_ranking(options)
      else
        ranking_provider.tip_ranking(options.merge(match_id: last_tip_ranking_set_match_id))
      end
    end
  end

  private

  attr_reader :ranking_provider
end