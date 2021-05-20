class Auth::RegistrationsController < ApplicationController
  include CreateSession
  before_action :authenticate_user, only: :destroy

  def create
    @user = User.new(registration_params)

    if @user.save
      @token = jwt_session_create @user.id
      if @token
        @token = "Bearer #{@token}"
        return success_user_created
      else
        return error_token_create
      end
    else
      error_user_save
    end
  end

  def destroy
    current_user.destroy
    success_user_destroy
  end

  protected

  def success_user_created
    response.headers['Authorization'] = "Bearer #{@token}"
    render status: :created, template: "auth/auth"
  end

  def success_user_destroy
    render status: :no_content, json: {}
  end

  def error_token_create
    render status: :unprocessable_entity, json: { errors: [I18n.t('errors.controllers.auth.token_not_created')] }
  end

  def error_user_save
    render status: :unprocessable_entity, json: { errors: @user.errors.full_messages }
  end

  private

  def registration_params
    params.permit(:name, :email, :password)
  end
end