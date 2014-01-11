class Venue < ActiveRecord::Base

  has_many :matches

  validates :city, presence: true
  validates :stadium, presence: true
  validates :capacity, presence: true
end
