class ApplicationController < ActionController::API
  ## ENTITIES
  include AuthenticateRequest

  ## MIDDLEWARE
  before_action :current_user
end
