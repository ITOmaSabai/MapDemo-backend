class Map < ApplicationRecord
  has_many :videos, dependent: :destroy
  has_one :addresses, dependent: :destroy

  validates :name, :lat, :lng, presence: true
end
