class Author < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :login, presence: true, uniqueness: true
  validate :email_val, :pass_val
  private
  def email_val
    unless email.include?('@')
      errors.add(:email, "invalid")
    end
  end

  def pass_val
    unless  password.count("a-z") <= 0 || password.count("A-Z") <= 0 || password.count((0-9).to_s) <= 0
      errors.add(:password, "must contain 1 small letter, 1 capital letter and number")
    end
  end
end
