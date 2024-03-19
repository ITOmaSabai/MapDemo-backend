class Like < ApplicationRecord
  belongs_to :map
  belongs_to :user

  validates :user_id, uniqueness: { scope: :spot_id }
end
