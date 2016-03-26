module Tips
  class SetResults < UseCase

    attribute :match_id, Integer

    def run
      match = Match.find(match_id)
      TipQueries.all_by_match_id(match_id).each do |tip|
        tip.set_result(match)
        tip.save
      end
    end
  end
end