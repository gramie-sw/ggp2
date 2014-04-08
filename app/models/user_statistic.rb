class UserStatistic
  include ActiveModel::Model

  attr_reader :user

  def initialize(user:, tournament:, current_ranking_item:)
    @user = user
    @tournament = tournament
    @current_ranking_item = current_ranking_item
  end

  delegate :position, :points, :correct_tips_count, :correct_tendency_tips_only_count, to: :current_ranking_item

  def correct_tips_ratio
    tip_ratio_for :correct_tips_count
  end

  def correct_tendency_tips_only_ratio
    tip_ratio_for :correct_tendency_tips_only_count
  end

  private

  attr_reader :tournament, :current_ranking_item

  def tip_ratio_for subject
    if tournament.played_match_count > 0
      #TODO cast to float and round
      send(subject) / tournament.played_match_count
    else
      0
    end
  end
end