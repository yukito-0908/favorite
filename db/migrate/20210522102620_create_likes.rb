class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :profile_id
      t.integer :post_id
      t.timestamps null: false
    end
  end
end
