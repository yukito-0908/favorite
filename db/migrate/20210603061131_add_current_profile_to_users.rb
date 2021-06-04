class AddCurrentProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_profile, :integer
  end
end
