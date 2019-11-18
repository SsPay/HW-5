class Post < ApplicationRecord
  belongs_to :author
  has_one_attached :picture
  validates :title, presence: true
  validates :name, presence: true
  validates :content, presence: true
end
