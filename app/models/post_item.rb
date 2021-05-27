class PostItem < ApplicationRecord
  belongs_to :post
  mount_uploaders :images, ImageUploader
end
