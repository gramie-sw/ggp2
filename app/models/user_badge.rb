class UserBadge < ActiveRecord::Base

  extend UserBadgeQueries

  belongs_to :user

end
