class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.references :user,foreign_key: true
      t.references :room,foreign_key: true
      t.timestamps null: false
    end
  end
end
