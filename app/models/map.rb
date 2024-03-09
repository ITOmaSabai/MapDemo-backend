class Map < ApplicationRecord
  has_many :videos, dependent: :destroy
  has_one :address, dependent: :destroy

  validates :name, :lat, :lng, presence: true
end
