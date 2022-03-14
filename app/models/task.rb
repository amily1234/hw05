class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :order_by_created_at, ->{ order(created_at: :asc) }
end
