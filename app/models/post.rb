# frozen_string_literal: true

class Post < ApplicationRecord
  is_impressionable counter_cache: true
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_one_attached :picture
  validates :title, presence: true
  validates :content, presence: true
  has_rich_text :content

  def self.search(search)
    where('title ILIKE ? OR plain_text ILIKE ?', "%#{search}%", "%#{search}%")
  end
end
