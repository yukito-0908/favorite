class User < ApplicationRecord
  enum is_active: { E: 0, F: 1, G: 2, H: 3 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  attachment :image
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 【class_name: "Relationship"】は省略可能
  has_many :followings, through: :relationships, source: :followed
  # 与フォロー関係を通じて参照→follower_idをフォローしている人3

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy



  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end

  def full_name
    first_name + last_name
  end



  def full_name_kana
    first_name_kana + last_name_kana
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def active_for_authentication?
    super && (self.is_active == "E")
  end

end
