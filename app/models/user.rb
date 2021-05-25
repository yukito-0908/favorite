class User < ApplicationRecord
  enum is_active: { E: 0, F: 1, G: 2, H: 3 }
  has_many :profiles, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
end
