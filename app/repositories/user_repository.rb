module UserRepository
  extend ActiveSupport::Concern

  included do
    scope :players_paginated, ->(page:, per_page:) { players.page(page).per(per_page) }
  end

end