class Aggregate < ActiveRecord::Base

  has_many :games
  has_ancestry
end
