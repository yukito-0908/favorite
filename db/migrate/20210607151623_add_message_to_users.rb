class AddMessageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :message, :text
  end
end
