class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user,foreign_key: true
      t.references :room,foreign_key: true
      t.text :message
      t.timestamps null: false
    end
  end
end
