class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tips, dependent: :destroy

  scope :players, -> { where(admin: false) }
  scope :admins, -> { where(admin: true) }

  def player?
    !admin?
  end
end
