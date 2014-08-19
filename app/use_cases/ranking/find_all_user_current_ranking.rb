class FindAllUserCurrentRanking

  def initialize(page)
    @page = page
  end

  def run
    CurrentRankingFinder.create_for_all_users.find(page: page)
  end

  private

  attr_reader :page
end