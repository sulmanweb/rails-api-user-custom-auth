class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/, message: I18n.t("errors.models.user.format_email") }
  validates :password, format: { with: /\A(?=.*).{8,72}\z/, message: I18n.t("errors.models.user.format_password") }, if: :password_required?

  before_save :downcase_email!

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
