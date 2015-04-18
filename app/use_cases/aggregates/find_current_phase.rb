module Aggregates
  class FindCurrentPhase < UseCase

    def run
      match = Match.next_match
      if match.nil?
        match = Match.last_match
      end
      match.present? ? match.phase : nil
    end
  end
end