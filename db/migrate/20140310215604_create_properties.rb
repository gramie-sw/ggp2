class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
