class CreateFollowRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_relationships do |t|
      t.references :follower, foreign_key: { to_table: :users }
      t.references :following, foreign_key: { to_table: :users }
      t.timestamp :created_at, default: Time.now
      t.timestamp :updated_at, default: Time.now
    end
      add_index :follow_relationships, [:follower_id, :following_id], unique: true
  end
end