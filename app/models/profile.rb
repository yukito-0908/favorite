class Profile < ApplicationRecord
  belongs_to :user
  attachment :image
end
