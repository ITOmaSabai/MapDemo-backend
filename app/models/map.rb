class Map < ApplicationRecord
  belongs_to :user
  has_many :videos, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, :lat, :lng, presence: true
end
