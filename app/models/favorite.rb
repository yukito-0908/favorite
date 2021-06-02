class Favorite < ApplicationRecord
  belongs_to :favorite_user, class_name: "User"
  belongs_to :favorited, class_name: "User"
end
