class Aggregate < ActiveRecord::Base

  has_ancestry

  class << self
    alias :phases :roots
  end

  has_many :matches, dependent: :destroy

  validates :position, presence: true, uniqueness: {scope: :ancestry}, numericality: {only_integer: true}, inclusion: {in: 1..1000}
  validates :name, presence: true, uniqueness: {scope: :ancestry}, length: {minimum: 3, maximum: 32}, technical_name_allowed_chars: true

  scope :order_by_position, -> { order('position ASC') }

  alias :phase? :is_root?
  alias :has_groups? :has_children?
  alias :groups :children

  def self.groupless_aggregates
    roots.map! do |root|
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

  def message_name
    "#{Aggregate.model_name.human}: \"#{name}\""
  end
end