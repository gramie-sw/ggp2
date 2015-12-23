class AddBadgeGroupIdentifierToUserBadges < ActiveRecord::Migration
  def change
    add_column :user_badges, :badge_group_identifier, :string
  end
end