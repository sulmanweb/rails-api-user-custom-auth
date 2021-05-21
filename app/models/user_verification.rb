class UserVerification < ApplicationRecord
  TOKEN_LENGTH = 32
  TOKEN_LIFETIME = 6.hours

  validates :status, presence: true, inclusion: %w[pending done failed]
  validates :verify_type, presence: true, inclusion: %w[confirm_email reset_email]

  validates :token, presence: true, uniqueness: {case_sensitive: true}

  belongs_to :user
  before_validation :generate_token, on: :create

  def self.search status='pending', verify_type='confirm_email', token
    UserVerification.where(status: status, verify_type: verify_type).find_by(token: token)
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.base58(TOKEN_LENGTH)
      break random_token unless UserVerification.exists?(token: random_token)
    end
  end
end
