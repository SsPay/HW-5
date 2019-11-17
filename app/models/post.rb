class Post < ApplicationRecord
  has_many :authors
  has_one_attached :picture
  validates :title, presence: true
  validates :name, presence: true
  validates :content, presence: true
end
