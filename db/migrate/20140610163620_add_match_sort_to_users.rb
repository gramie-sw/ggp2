class AddMatchSortToUsers < ActiveRecord::Migration
  def change
    add_column :users, :match_sort, :string
  end
end
