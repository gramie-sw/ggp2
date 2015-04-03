class DeleteVenues < ActiveRecord::Migration
  def up
    drop_table :venues
  end
  
  def down
    create_table :venues do |t|
      t.string :city
      t.string :stadium
      t.integer :capacity

      t.timestamps
    end
  end

end
