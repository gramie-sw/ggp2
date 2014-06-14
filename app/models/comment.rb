class Comment < ActiveRecord::Base

  include CommentRepository

  belongs_to :user

  validates :user, presence: true
  validates :content, presence: true, length: {maximum: 500}

  scope :order_by_created_at_desc, -> { order(created_at: :desc) }
  scope :comments_for_pin_board, ->(page) { order_by_created_at_desc.includes(:user).page(page).per(10) }

end
