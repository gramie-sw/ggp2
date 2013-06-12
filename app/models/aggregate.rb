class Aggregate < ActiveRecord::Base

  has_many :games, dependent: :destroy
  has_ancestry

  validates :position, presence: true, uniqueness: {scope: :ancestry}, numericality: {only_integer: true}, inclusion: {in: 1..1000}
  validates :name, presence: true, uniqueness: {scope: :ancestry}, length: {minimum: 3, maximum: 32}

  scope :order_by_position, lambda { order('position ASC') }

end
