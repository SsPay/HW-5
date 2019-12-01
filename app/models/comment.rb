class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  has_ancestry
end
