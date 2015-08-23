module Ranking
  class FindCurrentForAllUsers < UseCase

    attribute :page, Integer

    def run
      CurrentRankingFinder.create_for_all_users.find(page: page)
    end

    private

    attr_reader :page
  end
end