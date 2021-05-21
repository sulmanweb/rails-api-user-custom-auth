class Auth::PasswordsController < ApplicationController
  include CreateSession

  before_action :authenticate_user, only: [:reset_password]
  
  def create_reset_email
    return error_insufficient_params unless params[:email].present?
    user = User.find_by(email: params[:email])
    user.send_reset_email unless user.nil?
    success_send_reset_email
  end

  def verify_reset_email_token
    return error_insufficient_params unless params[:token]
    verification = UserVerification.search(:pending, :reset_email, params[:token])
    return error_invalid_token if verification.nil?
    if (verification.created_at + UserVerification::TOKEN_LIFETIME) > Time.now
      verification.update(status: :done)
      verification.user.confirm unless verification.user.confirmed?
      token = jwt_session_create verification.user_id
      # Redirect to the page where a logged in user can change its password
      redirect_to "#{ENV['REDIRECT_RESET_EMAIL']}?token=#{token}"
    else
      error_reset_email_late
    end
  end

  def reset_password
    @user = current_user
    return error_insufficient_params unless params[:password].present? && params[:confirm_password].present?
    return error_password_mismatch if params[:password] != params[:confirm_password]
    if @user.update(password: params[:password])
      return success_password_reset
    else
      return error_user_save
    end
  end

  protected

  def error_insufficient_params
    render status: :unprocessable_entity, json: {errors: [I18n.t('errors.controllers.insufficient_params')]}
  end

  def success_send_reset_email
    render status: :created, json: {message: I18n.t('messages.reset_password_email_sent')}
  end

  def success_password_reset
    render status: :ok, json: {message: I18n.t('messages.email_reset_success')}
  end

  def error_reset_email_late
    render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.verifications.late')]}
  end

  def error_invalid_token
    render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.verifications.invalid_token')]}
  end

  def error_user_save
    render status: :unprocessable_entity, json: {errors: @user.errors.full_messages}
  end

  def error_password_mismatch
    render status: :unprocessable_entity, json: {errors: [I18n.t('errors.controllers.auth.password_mismatch')]}
  end
end