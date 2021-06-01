class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :profile_id
end
