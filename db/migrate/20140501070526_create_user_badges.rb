class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|
      t.references :user, index: true
      t.string :badge_identifier
      t.string :group

      t.timestamps
    end
  end
end
