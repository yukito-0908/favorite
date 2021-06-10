class AddIsActiveToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_active, :boolean,default: true
  end
end
