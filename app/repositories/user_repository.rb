module UserRepository
  extend ActiveSupport::Concern

  included do
    scope :order_by_nickname_asc, -> { order(nickname: :asc) }

    scope :users_listing, ->(admin:, page:, per_page:) do
      users = admin ? admins : players
      users.page(page).per(per_page)
    end
  end
end