class Aggregate < ActiveRecord::Base

  include AggregateRepository

  has_ancestry

  class << self
    alias :phases :roots
  end

  has_many :matches, dependent: :destroy

  validates :position, presence: true, uniqueness: {scope: :ancestry}, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 1000}
  validates :name, presence: true, uniqueness: {scope: :ancestry}, length: {minimum: 3, maximum: 32}, technical_name_allowed_chars: true

  scope :order_by_position_asc, -> { order('position ASC') }

  alias :phase? :is_root?
  alias :has_groups? :has_children?
  alias :groups :children

  def self.groupless_aggregates
    roots.to_a.map! do |root|
      if root.has_groups?
        root.children
      else
        root
      end
    end.flatten!
  end

  def group?
    !phase?
  end

  def matches_including_of_children
    if phase? && has_groups?
      Match.where(aggregate_id: children).references(:aggregates)
    else
      matches
    end
  end

  def future_matches
    matches_including_of_children.future_matches
  end

  def has_future_matches?
    future_matches.present?
  end

  def message_name
    "#{Aggregate.model_name.human}: \"#{name}\""
  end
end