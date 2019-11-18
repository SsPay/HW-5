class Post < ApplicationRecord
  is_impressionable counter_cache: true
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_one_attached :picture
  validates :title, presence: true
  validates :content, presence: true
end
