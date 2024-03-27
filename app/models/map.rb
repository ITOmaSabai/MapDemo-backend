class Map < ApplicationRecord
  belongs_to :user
  has_many :videos, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, :lat, :lng, presence: true
  validate :post_once_per_day

  private

  def post_once_per_day
    if user.maps.where('created_at >= ?', Time.zone.now.beginning_of_day).exists?
      errors.add(:base, "スポットの新規投稿は1日1回まで可能です")
    end
  end
end
