class Post < ApplicationRecord
  belongs_to :author
  has_many :comments
  has_one_attached :picture
  validates :title, presence: true
  validates :content, presence: true
end
