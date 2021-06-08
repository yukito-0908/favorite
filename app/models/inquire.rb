class Inquire < ApplicationRecord
  belongs_to :user
  attr_accessor :name, :email, :message
end
