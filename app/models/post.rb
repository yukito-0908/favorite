class Post < ApplicationRecord
  belongs_to :profile
  has_many :post_items
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :likes,  dependent: :destroy
  accepts_nested_attributes_for :post_items


  def save_tags(post_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - post_tags
    new_tags = post_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << post_tag
    end
  end


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
