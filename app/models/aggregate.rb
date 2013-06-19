class Aggregate < ActiveRecord::Base

  has_many :games, dependent: :destroy
  has_ancestry

  validates :position, presence: true, uniqueness: {scope: :ancestry}, numericality: {only_integer: true}, inclusion: {in: 1..1000}
  validates :name, presence: true, uniqueness: {scope: :ancestry}, length: {minimum: 3, maximum: 32}, technical_name_allowed_chars: true

  scope :order_by_position, lambda { order('position ASC') }

  alias :is_phase? :is_root?
  alias :has_groups? :has_children?
  alias :groups :children

  def is_group?
    !is_root?
  end

  def games_of_branch
    if is_phase? && has_groups?
      Game.where(aggregate_id: children)
    else
      games
    end
  end
end