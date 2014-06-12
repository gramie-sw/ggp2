class UserStatistic
  include ActiveModel::Model

  delegate :badges_count,
           to: :user

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

  attr_reader :tournament, :current_ranking_item, :user

  def tip_ratio_for subject
    if tournament.played_match_count > 0
      (send(subject).to_f / tournament.played_match_count.to_f * 100).to_i
    else
      0
    end
  end
end