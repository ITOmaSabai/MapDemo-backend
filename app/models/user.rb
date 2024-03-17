class User < ApplicationRecord
  has_many :maps, dependent: :destroy
  has_many :likes, dependent: :destroy
end
