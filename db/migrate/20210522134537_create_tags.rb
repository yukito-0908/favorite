class CreateTags < ActiveRecord::Migration[5.0]
  def change
     create_table :tags do |t|
      t.string :tag_name,null: false
      t.timestamps null: false
    end
  end
end
