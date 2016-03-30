class AddMostValuableBadgeToUser < ActiveRecord::Migration
  def change
    add_column :users, :most_valuable_badge, :string
  end
end
