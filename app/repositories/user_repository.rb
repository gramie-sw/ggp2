module UserRepository
  extend ActiveSupport::Concern

  included do
    scope :players_for_ranking_listing, ->(page:, per_page:) do
      players.page(page).per(per_page).includes(champion_tip: :team)
    end
  end

end