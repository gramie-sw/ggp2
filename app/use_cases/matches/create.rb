module Matches
  class Create < UseCase

    attribute :match_attributes

    def run
      ActiveRecord::Base.transaction do
        match = Match.create(match_attributes)

        if match.errors.blank?
          User.players.each do |user|
            Tip.create(user_id: user.id, match_id: match.id)
          end
        end

        match
      end
    end
  end
end