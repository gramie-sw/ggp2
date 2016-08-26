module Aggregates
  class FindCurrentPhase < UseCase

    def run
      match = MatchQueries.next_match
      if match.nil?
        match = MatchQueries.last_match
      end
      match.present? ? match.phase : Aggregate.first
    end
  end
end