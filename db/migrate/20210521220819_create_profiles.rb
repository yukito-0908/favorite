class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :is_active, default: 0
      t.string :instagram_id
      t.string :name
      t.text :introduction
      t.string :image_id
      t.timestamps null: false
    end
  end
end
