class AddTitleholderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :titleholder, :boolean
  end
end
