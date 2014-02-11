class Aggregate < ActiveRecord::Base

  has_many :matches, dependent: :destroy
  has_ancestry

  validates :position, presence: true, uniqueness: {scope: :ancestry}, numericality: {only_integer: true}, inclusion: {in: 1..1000}
  validates :name, presence: true, uniqueness: {scope: :ancestry}, length: {minimum: 3, maximum: 32}, technical_name_allowed_chars: true

  scope :order_by_position, -> { order('position ASC') }

  alias :is_phase? :is_root?
  alias :has_groups? :has_children?
  alias :groups :children

  def is_group?
    !is_root?
  end

  def matches_of_branch
    if is_phase? && has_groups?
      Match.where(aggregate_id: children)
    else
      matches
    end
  end

  def self.leaves
    roots.map! do |root|
      if root.has_groups?
        root.children
      else
        root
      end
    end.flatten!
  end
end