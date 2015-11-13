module ChampionTipQueries

  class << self

    def clear_all_results
      ChampionTip.update_all(result: nil)
    end
  end
end