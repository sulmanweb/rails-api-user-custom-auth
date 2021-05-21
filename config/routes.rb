Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :auth do
    post "sign_up", to: "registrations#create"
    delete "destroy", to: "registrations#destroy"
    post "sign_in", to: "sessions#create"
    get "validate_token", to: "sessions#validate_token"
    delete "sign_out", to: "sessions#destroy"
    get "confirm_email", to: "confirmations#confirm_email"
    put "resend_confirm_email", to: "confirmations#resend_confirm_email"
    post "forgot_password_email", to: "passwords#create_reset_email"
    get "verify_reset_password_email", to: "passwords#verify_reset_email_token"
    put "reset_password", to: "passwords#reset_password"
  end
end
