module PointsValidatable
  extend ActiveSupport::Concern

  included do
    validates :points,
              numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000},
              allow_nil: true
  end
end