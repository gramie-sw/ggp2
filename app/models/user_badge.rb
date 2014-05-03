class UserBadge < ActiveRecord::Base

  include UserBadgeRepository

  belongs_to :user
end
