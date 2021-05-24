class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :user,foreign_key: true
      t.timestamps null: false
    end
  end
end
