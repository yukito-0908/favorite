# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.string :last_name
      t.string :first_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.string :phone_number
      t.boolean :is_active,  default: true
      t.timestamp :created_at, default: Time.now
      t.timestamp :updated_at, default: Time.now
    end
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
