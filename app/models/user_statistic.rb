class UserStatistic
  include ActiveModel::Model

  attr_reader :user

  def initialize(user:, tournament:, current_ranking_item: nil)
    @user = user
    @tournament = tournament
    @current_ranking_item = current_ranking_item
  end

  delegate :position, :correct_tips_count, :correct_tendency_tips_only_count, to: :current_ranking_item

  def correct_tips_percentage

  end

  def correct_tendency_only_tips_percentage

  end

  private

  attr_reader :tournament

  def current_ranking_item
    @current_ranking_item ||= begin
      RankingItem.new(position: 0, correct_tips_count: 0, correct_tendency_tips_only_count: 0)
    end
  end

end