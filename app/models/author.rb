class Author < ApplicationRecord
  has_secure_password
  has_many :posts
  validates :email, presence: true, uniqueness: true
  validates :login, presence: true, uniqueness: true
end
