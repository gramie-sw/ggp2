class CreateAggregates < ActiveRecord::Migration
  def change
    create_table :aggregates do |t|
      t.integer :position
      t.string :name
      t.string :ancestry

      t.timestamps
    end
  end
end
