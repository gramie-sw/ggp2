class RemoveBadgeValuesFromUserBadges < ActiveRecord::Migration
  def change
    remove_column :user_badges, :position, :integer
    remove_column :user_badges, :icon, :string
    remove_column :user_badges, :icon_color, :string
    remove_column :user_badges, :group, :string
  end
end
