module AggregateRepository
  extend ActiveSupport::Concern

  included do
    scope :all_phased_ordered_by_position_asc, -> { phases.order_by_position }
  end

end