class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :tag_maps

  def posts_tag
    posts.count
  end
end
