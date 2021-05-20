Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :auth do
    post "sign_up", to: "registrations#create"
  end
end
