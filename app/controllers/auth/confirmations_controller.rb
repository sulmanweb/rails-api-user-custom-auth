class Auth::ConfirmationsController < ApplicationController
  include CreateSession

  before_action :authenticate_user, only: :resend_confirm_email

  def confirm_email
    return error_insufficient_params unless params[:token]

    verification = UserVerification.search(:pending, :confirm_email, params[:token])
    return error_invalid_token if verification.nil?
    if (verification.created_at + UserVerification::TOKEN_LIFETIME) > Time.now
      verification.user.confirm
      verification.update(status: :done)
      @token = jwt_session_create verification.user_id
      # Redirect to the page that says the email is confirmed successfully or can be redirected to the app
      redirect_to "#{ENV['REDIRECT_CONFIRM_EMAIL']}?token=#{@token}"
    else
      error_confirm_email_late
    end
  end

  def resend_confirm_email
    current_user.send_confirm_email
    success_resend_confirm_email
  end

  protected

  def success_resend_confirm_email
    render status: :ok, json: {message: I18n.t('messages.resend_confirm_email')}
  end

  def error_insufficient_params
    render status: :unprocessable_entity, json: {errors: [I18n.t('errors.controllers.insufficient_params')]}
  end

  def error_confirm_email_late
    render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.verifications.late')]}
  end

  def error_invalid_token
    render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.verifications.invalid_token')]}
  end
end