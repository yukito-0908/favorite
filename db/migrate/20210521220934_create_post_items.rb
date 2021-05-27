class CreatePostItems < ActiveRecord::Migration[5.0]
  def change
    create_table :post_items do |t|
      t.integer :post_id
      t.string :item
      t.string :post_item_image
      t.string :place
      t.json :images
      t.text :introduction
      t.timestamps null: false
    end
  end
end
