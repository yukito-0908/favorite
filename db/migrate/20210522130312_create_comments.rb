class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :comment_content
      t.references :profile, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps null: false
    end
  end
end
