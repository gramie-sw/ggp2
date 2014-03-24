class Comment < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :content, presence: true, length: {maximum: 500}

  scope :order_by_created_at_desc, -> { order(created_at: :desc) }
end
