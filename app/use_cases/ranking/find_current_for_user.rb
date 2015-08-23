module Ranking
  class FindCurrentForUser < UseCase

    attribute :user_id, Integer

    def run
      CurrentRankingFinder.create_for_single_user.find(user_id: user_id)
    end
  end
end