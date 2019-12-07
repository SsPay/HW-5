class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  has_many :votes, dependent: :destroy
  has_ancestry
  validates :body, presence: true
end
