class AddImageToPostItems < ActiveRecord::Migration[5.2]
  def change
    add_column :post_items, :images, :json
  end
end
