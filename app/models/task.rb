class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :end_time, presence: true
  validates :status_type, presence: true
  scope :order_by_created_at, -> { order(created_at: :asc) }
  scope :order_by_end_time, -> { order(end_time: :asc) }
  scope :search_status_type, ->(p) { where("status_type LIKE ?", p) }
  scope :search_title_or_content, ->(p) { where('title LIKE ? OR content LIKE ?', p, p) }

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end

  def tag_items
    tags.map(&:name)
  end

  def tag_items=(names)
    self.tags = names.map{|item|
      Tag.where(name: item.strip).first_or_create! unless item.blank?}.compact!
  end
end
