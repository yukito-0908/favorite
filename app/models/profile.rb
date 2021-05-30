class Profile < ApplicationRecord
   belongs_to :user
    has_many :posts, dependent: :destroy
  enum is_active: { A: 0, B: 1, C: 2, D: 3 }
  attachment :image
  validates :name, presence: true
  validates :instagram_id, presence: true
  validates :introduction, presence: true


  def current_user?(current_user)
    user == current_user
  end

end
