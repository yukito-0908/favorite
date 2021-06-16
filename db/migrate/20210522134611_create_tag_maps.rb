class CreateTagMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_maps do |t|
      t.integer :post_id
      t.integer :tag_id
      t.timestamps null: false
    end
  end
end
