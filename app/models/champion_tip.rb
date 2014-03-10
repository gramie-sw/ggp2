class ChampionTip < ActiveRecord::Base

  belongs_to :user
  belongs_to :team

  validates :team, presence: true, on: :update

end
