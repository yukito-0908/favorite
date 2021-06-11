class AddTaggingsCountToTaggings < ActiveRecord::Migration[5.2]
  def change
    add_column :taggings, :taggings_count, :integer
  end
end
