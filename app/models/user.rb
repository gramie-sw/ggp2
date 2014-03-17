class User < ActiveRecord::Base

  USER_TYPE_ADMINS = 'admins'
  USER_TYPE_PLAYERS = 'players'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tips, dependent: :destroy, inverse_of: :user
  has_many :ranking_items, dependent: :destroy, inverse_of: :user
  has_one :champion_tip, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true, length: {minimum: 3, maximum: 32}
  validates :first_name, presence: true, length: {maximum: 32}
  validates :last_name, presence: true, length: {maximum: 32}
  validates :admin, inclusion: {in: [true, false]}

  scope :players, -> { where(admin: false) }
  scope :admins, -> { where(admin: true) }
  scope :order_by_nickname_asc, -> { order(nickname: :asc) }

  def self.find_player id
    players.where(id: id).first
  end

  def player?
    !admin?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def message_name
    "#{User.model_name.human} \"#{first_name} #{last_name}\""
  end
end
