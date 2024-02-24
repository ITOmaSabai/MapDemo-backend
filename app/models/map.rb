class Map < ApplicationRecord
  has_many :videos, dependent: :destroy

  validates :name, :lat, :lng, presence: true
end
