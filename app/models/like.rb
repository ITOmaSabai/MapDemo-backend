class Like < ApplicationRecord
  belongs_to :map
  belongs_to :user

  validates :user_id, uniqueness: { scope: :map_id }
end
