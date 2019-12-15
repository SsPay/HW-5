# frozen_string_literal: true

class Author < ApplicationRecord
  validate :email_val, :pass_val
  validates :password, presence: true,
                       length: { minimum: 8 }
  has_secure_password
  before_create :confirmation_token
  after_create :send_confirmation
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :login, presence: true, uniqueness: true
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def send_password_reset
    confirmation_token
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    AuthorMailer.password_reset(self).deliver!
  end

  private

  def email_val
    errors.add(:email, 'invalid') unless email.include?('@')
    end

  def pass_val
    if password.count('a-z') <= 0 || password.count('A-Z') <= 0 # || password_digest.count((0-9).to_s) <= 0
      errors.add(:password, 'must contain 1 small letter, 1 capital letter and minimum 8 symbols')
    end
  end

  def send_confirmation
    AuthorMailer.registration_confirmation(self).deliver!
    end

  def confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
    end
end
