module UserRepository
  extend ActiveSupport::Concern

  included do
    scope :order_by_nickname_asc, -> { order(nickname: :asc) }
  end
end