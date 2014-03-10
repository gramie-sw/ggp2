class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :last_result_match_id

      t.timestamps
    end
  end
end
