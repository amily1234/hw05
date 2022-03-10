class Task < ApplicationRecord
  scope :order_by_created_at, ->{ order(created_at: :asc) }
end
