class Post < ApplicationRecord
  belongs_to :user
  has_many :post_items
  acts_as_taggable   # acts_as_taggable_on :tags の省略
# 参)複数設定も可能↓
  acts_as_taggable_on :skills, :interests  # @post.skill_list とかが使えるようになる
  has_many :likes,  dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :post_items
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 被フォロー関係を通じて参照→followed_idをフォローしている人

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 【class_name: "Relationship"】は省略可能
  has_many :followings, through: :relationships, source: :followed
  # 与フォロー関係を通じて参照→follower_idをフォローしている人





def liked_by?(profile)
  likes.where(profile_id: profile_id).exists?
end


def self.search(profile_id,keyword)
  where(["profile_id = ? and (title like ? OR introduction like ?)","##{profile_id}" ,"%#{keyword}%", "%#{keyword}%"])
end


  mount_uploaders :images, ImageUploader
  enum genre_name: { 寿司・魚料理: 0, 和食・日本料理: 1, ラーメン・麺類: 2, 丼もの・揚げ物: 3,
                    お好み焼き・粉物: 4, 郷土料理: 5, アジア・エスニック: 6, 中華: 7,
                    イタリアン: 8, 要職・西洋料理: 9,  フレンチ: 10,  アメリカ料理: 11,
                    アフリカ料理: 12,  珍しい各国料理: 13,  焼肉・ステーキ: 14,  焼き鳥・串料理: 15,
                    こだわり肉料理: 16,  鍋: 17,  しゃぶしゃぶ・すき焼き: 18,  居酒屋・バー: 19,
                    カフェ・スイーツ: 20,  ファミレス・ファストフード: 21, ピッフェ・バイキング: 22}
end
