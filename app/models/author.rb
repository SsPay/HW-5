class Author < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :login, presence: true, uniqueness: true
  validate :email_val
  private
  def email_val
    unless email.include?('@')
      errors.add(:email, "invalid")
    end
  end
end
