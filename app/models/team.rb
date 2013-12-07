class Team < ActiveRecord::Base

  has_many :team_1_games, :class_name => "Game", :foreign_key => "team_1_id"
  has_many :team_2_games, :class_name => "Game", :foreign_key => "team_2_id"

  validates :country, presence: true, uniqueness: true, length: {maximum: 255}
  #validates :abbreviation, presence: true, uniqueness: true, :length => {:is => 3}

  #scope :order_by_name, lambda { order('name ASC') }

  before_destroy :before_destroy

  def before_destroy
    unless team_1_games.empty? && team_2_games.empty?
      errors.add :base, I18n.t('errors.messages.team_to_delete_is_associated_to_games')
      false
    end
  end
end
