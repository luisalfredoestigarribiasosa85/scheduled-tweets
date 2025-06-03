# email:string
# password_digest:string
# password:string virtual
# password_confirmation:string virtual

class User < ApplicationRecord
  has_secure_password

  SPAM_DOMAINS = [
    "tempmail.com",
    "throwawaymail.com",
    "mailinator.com",
    "guerrillamail.com",
    "10minutemail.com",
    "yopmail.com",
    "temp-mail.org",
    "sharklasers.com",
    "spamgourmet.com",
    "trashmail.com"
  ].freeze

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  validates :password, presence: true

  validate :email_not_from_spam_domain

  private

  def email_not_from_spam_domain
    return if email.blank?

    domain = email.split("@").last.downcase
    if SPAM_DOMAINS.include?(domain)
      errors.add(:email, "cannot be from a disposable email service")
    end
  end
end
