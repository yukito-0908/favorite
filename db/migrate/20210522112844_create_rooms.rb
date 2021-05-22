class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :user,foreign_key: true
      t.timestamp :created_at, default: Time.now
      t.timestamp :updated_at, default: Time.now
    end
  end
end
