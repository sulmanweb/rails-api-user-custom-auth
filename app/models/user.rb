class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/, message: I18n.t("errors.models.user.format_email") }
  validates :password, format: { with: /\A(?=.*).{8,72}\z/, message: I18n.t("errors.models.user.format_password") }, if: :password_required?

  before_save :downcase_email!
  after_create :send_confirm_email

  has_many :sessions, dependent: :destroy
  has_many :user_verifications, dependent: :destroy

  def confirmed?
    !email_confirmed_at.nil?
  end

  def confirm
    update(email_confirmed_at: Time.now)
  end

  def unconfirm
    update(email_confirmed_at: nil)
  end

  def send_confirm_email
    unless confirmed?
      verification = UserVerification.create(user_id: id, verify_type: :confirm_email)
      url = Rails.application.routes.url_helpers.auth_confirm_email_url(host: "localhost:3000", token: verification.token)
      # ADD Email Job with `url` added in "CONFIRM EMAIL" button
    end
  end

  def send_reset_email
    if confirmed?
      verification = UserVerification.create(user_id: id, verify_type: :reset_email)
      url = Rails.application.routes.url_helpers.auth_verify_reset_password_email_url(host: "localhost:3000", token: verification.token)
      # ADD Email Job with `url` added in "RESET YOUR EMAIL" button
    end
  end

  private

  # is password required for user?
  def password_required?
    password_digest.nil? || !password.blank?
  end

  # downcase email
  def downcase_email!
    email&.downcase!
  end
end
