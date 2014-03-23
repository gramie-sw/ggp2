class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.text :content
      t.boolean :edited

      t.timestamps
    end
  end
end
