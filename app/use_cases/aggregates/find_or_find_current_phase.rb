module Aggregates
  class FindOrFindCurrentPhase < UseCase

    attribute :id

    def run

      if id.present?
        Aggregate.find(id)
      else
        FindCurrentPhase.run
      end
    end

  end
end