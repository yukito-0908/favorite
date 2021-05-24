class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :profile_id
      t.string :title
      t.string :post_image
      t.string :tag
      t.text :introduction
      t.integer :price
      t.integer :genre_name, default: 0
      t.timestamps null: false
    end
  end
end
