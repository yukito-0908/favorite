class AddTaggingsCountToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :taggings_count, :integer
  end
end
