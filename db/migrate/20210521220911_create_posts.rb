class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.string :tag
      t.string :picture
      t.text :introduction
      t.json :images
      t.integer :price
      t.integer :genre_name, default: 0
      t.timestamps null: false
    end
  end
end
