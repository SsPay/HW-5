# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  has_many :votes, dependent: :destroy
  has_ancestry orphan_strategy: :adopt
  validates :body, presence: true
end
