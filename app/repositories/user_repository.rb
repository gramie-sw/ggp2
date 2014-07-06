module UserRepository
  extend ActiveSupport::Concern

  included do
    scope :order_by_nickname_asc, -> { order(nickname: :asc) }

    scope :players_for_ranking_listing, ->(page:, per_page:) do
      users_listing(admin: false, page: page, per_page: per_page).includes(champion_tip: :team)
    end

    scope :users_listing, ->(admin:, page:, per_page:) do
      users = admin ? admins : players
      users.page(page).per(per_page)
    end
  end
end